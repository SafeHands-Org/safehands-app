import bcrypt from "bcryptjs";
import { eq } from "drizzle-orm";
import jwt from "jsonwebtoken";

import { db } from "../db";
import { users } from "../db/schema/users";
import { sessionsTable } from "../db/schema/sessions";
import { NewUserBody } from "../models/auth.model"
import { User, Session, TokenPayload } from "../db/types"
import config from "../config/config";
import * as throwErr from "../utils/error.handling";

const JWT_SECRET = config.jwt_secret || "supersecret";
const TOKEN_EXPIRES_IN = "30d";

export const createUser = async (data: NewUserBody): Promise<User> => {
  const [existingUser] = await db
    .select()
    .from(users)
    .where(eq(users.email, data.email))
    .limit(1);

  if (existingUser) throwErr.badRequest("User already exists");

  const hashedPassword = await bcrypt.hash(data.password, 12);

  const [newUser] = await db
    .insert(users)
    .values({
    ...data,
    passwordHash: hashedPassword,
    createdAt: new Date(),
    updatedAt: new Date(),
  })
  .returning();

  return newUser;
};

export const getSessionUser = async (sessionToken: string): Promise<User | null> => {
  const [session] = await db
    .select()
    .from(sessionsTable)
    .where(eq(sessionsTable.sessionToken, sessionToken))
    .limit(1);

  if (!session) return null;

  if (new Date(session.expiresAt) < new Date()) return null;

  const [user] = await db
    .select()
    .from(users)
    .where(eq(users.id, session.userId))
    .limit(1);

  return user ?? null;
};

export const getSessionByToken = async (token: string): Promise<Session| null> => {
  const [session] = await db
    .select()
    .from(sessionsTable)
    .where(eq(sessionsTable.sessionToken, token))
    .limit(1);
  
  if (!session) return null;

  return {
    sessionToken: session.sessionToken,
    userId: session.userId,
    expiresAt: new Date(session.expiresAt),
  };
};

export const storeSession = async (session: Session): Promise<void> => {
  await db.insert(sessionsTable).values({
    userId: session.userId,
    sessionToken: session.sessionToken,
    expiresAt: session.expiresAt,
    createdAt: new Date(),
    updatedAt: new Date(),
  });
};

export const createSessionToken = async (payload: TokenPayload): Promise<string> => {
  return jwt.sign(payload, JWT_SECRET, {expiresIn: TOKEN_EXPIRES_IN});
};