import type { Request, Response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { z } from "zod";
import { db } from "../../db";
import { users } from "../../db/schema/users";
import { eq } from "drizzle-orm";

const loginSchema = z.object({
  email: z.email("Invalid email"),
  password: z.string().min(6, "Password must be at least 6 characters"),
});

const JWT_SECRET = process.env.JWT_SECRET || "supersecret";

export const loginUser = async (req: Request, res: Response) => {
  const parseResult = loginSchema.safeParse(req.body);
  if (!parseResult.success) {
    return res.status(422).json({
      success: false,
      message: "Validation failed",
      errors: parseResult.error.flatten().fieldErrors,
    });
  }

  const { email, password } = parseResult.data;

  try {
    // Find user by email
    const foundUsers = await db
      .select().from(users)
      .where(eq(users.email, email))
      .limit(1);

    const user = foundUsers[0];

    if (!user) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    // Compare passwords
    const passwordMatch = await bcrypt.compare(password, user.passwordHash);
    if (!passwordMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid email or password.",
      });
    }

    // Generate JWT
    const token = jwt.sign(
      { userId: user.id, email: user.email, role: user.role },
      JWT_SECRET,
      { expiresIn: "30d" }
    );

    res.status(200).json({
      success: true,
      message: "Login successful.",
      user: {
        id: user.id,
        full_name: user.name,
        email: user.email,
        role: user.role,
      },
      token,
    });
  } catch (error) {
    console.error("Login Error:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error during login.",
    });
  }
};