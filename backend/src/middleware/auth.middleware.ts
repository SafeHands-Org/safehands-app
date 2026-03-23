import { NextFunction, Request, Response } from "express";
import jwt, { JwtPayload } from "jsonwebtoken";

import config from "../config/config";
import { getSessionByToken } from "../services/auth.service";
import * as service from "../services/family.service";
import * as throwErr from "../utils/error.handling";

declare module "express-serve-static-core" {
  interface Request {
		user?: {
			id: string;
			role: string;
			session?: {
				sessionToken: string;
				expiresAt: Date;
			};
		};
	}
}

export const authMiddleware = async (req: Request, res: Response, next: NextFunction) => {
	const token = req.headers["authorization"];
	const rawToken = token?.split(" ")[1];

	if (!rawToken) return throwErr.unauthorized("No session token");

	const decoded = jwt.verify(rawToken, config.jwt_secret) as JwtPayload & {
		id: string;
		name: string;
		email: string;
		role: string;
	};

	const session = await getSessionByToken(rawToken);
	if (!session) return res.status(401).json({ success: false, message: "Session not found" });
	if (new Date(session.expiresAt) < new Date()) return res.status(401).json({ success: false, message: "Session expired" });

	req.user = {
		id: decoded.id,
		role: decoded.role,
		session: session,
	};
	next();
};