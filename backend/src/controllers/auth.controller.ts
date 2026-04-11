import { Request, Response } from "express";
import { addDays } from "date-fns";
import bcrypt from "bcryptjs";

import { getUserByEmail} from "../services/user.service";
import { createUser, createSessionToken, storeSession } from "../services/auth.service";
import * as throwErr from "../utils/error.handling"

export const me = async (req: Request, res: Response): Promise <void> => {
  if (!req.user) return throwErr.unauthorized("Not Logged In");

  res.status(200).json({ user: { id: req.user.id, role: req.user.role}});
};

export const registerUser = async (req: Request, res: Response): Promise<void> => {
  const registerUser = await createUser(req.body);

  const payload = {
    id: registerUser.id,
    name: registerUser.name,
    email: registerUser.email,
    role: registerUser.role,
  };

  const sessionToken = await createSessionToken(payload);
  const expiresAt = addDays(new Date(), 30);

  await storeSession({userId: registerUser.id, sessionToken, expiresAt});

  res.setHeader("Authorization", `Bearer ${sessionToken}`);
  res.status(201).json({
    success: true,
    message: "Account Creation Successful",
    user: registerUser,
    token: sessionToken,
  });
};

export const loginUser = async (req: Request, res: Response): Promise<void> => {
  const { email, password } = req.body;

  const user = await getUserByEmail(email);
  if (!user) return throwErr.notFound("Invalid email or password");

  const validPassword = await bcrypt.compare(password, user.passwordHash);
  if (!validPassword) return throwErr.unauthorized("Invalid email or password");

  const payload = {
    id: user.id,
    name: user.name,
    email: user.email,
    role: user.role,
  };

  const sessionToken = await createSessionToken(payload);
  const expiresAt = addDays(new Date(), 30);

  await storeSession({userId: user.id, sessionToken, expiresAt});

  res.setHeader("Authorization", `Bearer ${sessionToken}`);
  res.status(200).json({
    success: true,
    message: "Authentication Successful",
    user: {
      id: user.id,
      name: user.id,
      email: user.email,
      role: user.role
    },
  });
};
