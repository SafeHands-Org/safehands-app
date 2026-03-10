import { Request, Response, NextFunction } from "express";
import jwt, { JwtPayload } from "jsonwebtoken";

import config from "../config/config";
import { getSessionByToken } from "../services/auth.service";
import * as throwErr from "../utils/error.handling";

declare module "express-serve-static-core" {
  interface Request {
    user: { userId: string; role: string };
    session: { sessionToken: string; userId: string; expiresAt: Date };
  }
}

export const authMiddleware = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let token: string | undefined = req.cookies?.session_token;

  if (!token) {
    const authHeader = req.headers.authorization;
    if (authHeader?.startsWith("Bearer ")) {
      token = authHeader.slice(7);
    }
  }

  if (!token) return throwErr.unauthorized("No session token");

  let decoded: JwtPayload & { id?: string; userId?: string; role: string };
  try {
    decoded = jwt.verify(token, config.jwt_secret) as typeof decoded;
  } catch {
    return throwErr.unauthorized("Invalid or expired token");
  }

  const userId = decoded.id ?? decoded.userId;
  if (!userId) return throwErr.unauthorized("Token missing user id");

  req.user = { userId, role: decoded.role };

  const session = await getSessionByToken(token);
  if (!session) {
    return res
      .status(401)
      .json({ success: false, message: "Session not found" });
  }
  if (new Date(session.expiresAt) < new Date()) {
    return res
      .status(401)
      .json({ success: false, message: "Session expired" });
  }

  req.session = session;
  next();
};