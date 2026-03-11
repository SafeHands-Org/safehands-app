import { Request, Response, NextFunction } from "express";
import jwt, { JwtPayload } from "jsonwebtoken";

import config from "../config/config";
import { getSessionByToken } from "../services/auth.service";
import * as throwErr from "../utils/error.handling";

declare module "express-serve-static-core" {
  interface Request {
    user: { 
      id: string, 
      name: string,
      email: string,
      role: string,
      createdAt: string,
      updatedAt: string
    };
    session: { sessionToken: string; userId: string; expiresAt: Date };
  }
}

export const authMiddleware = async (req: Request, res: Response, next: NextFunction) => {
  const token = req.headers["authorization"];
  const rawToken = token?.split(" ")[1];

  if (!rawToken) return throwErr.unauthorized("No session token");

  const decoded = jwt.verify(token, config.jwt_secret) as JwtPayload & { 
    id: string, 
    name: string,
    email: string,
    role: string,
    createdAt: string,
    updatedAt: string
  };
  
  req.user = { 
    id: decoded.userId, 
    name: decoded.name,
    email: decoded.email,
    role: decoded.role,
    createdAt: decoded.createdAt,
    updatedAt: decoded.updatedAt,
  };

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