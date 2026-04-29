import { NextFunction, Request, Response } from "express";
import jwt, { JwtPayload } from "jsonwebtoken";

import config from "../config/config";
import { getSessionByToken } from "../services/auth.service";
import * as throwErr from "../utils/error.handling";

declare module "express-serve-static-core" { interface Request {
	user?: { id: string, role: string }
}}

export const getParam = (param: string | string[], name = "parameter"): string => {
	if (!param) {
    throwErr.badRequest(`Missing ${name}`);
    throw new Error(`Missing ${name}`);
  }
	return Array.isArray(param) ? param[0] : param;
};

export const isAuthDisabled = config.node_env === 'development';

export const authMiddleware = async (req: Request, res: Response, next: NextFunction) => {
	if (isAuthDisabled) {
		req.user = { id: '8daf9445-940d-48dc-b946-9ad9efdd171f', role: 'caregiver'};
		return next();
	}

	const token = req.headers["authorization"];
	const rawToken = token?.split(" ")[1];

	if (!rawToken) return throwErr.unauthorized("No session found");

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
	};

	next();
};