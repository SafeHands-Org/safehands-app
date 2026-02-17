import { Request, Response } from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { z } from "zod";
import { db } from "../../db";
import { users } from "../../db/schema/users";
import { eq } from "drizzle-orm";

const registerSchema = z.object({
  name: z.string().min(1, "Name is required"),
  email: z.email("Invalid email"),
  password: z.string().min(8, "Password must be at least 8 characters"),
  role: z.enum(["caregiver", "family_member", "clinician"]).optional(),
});

const JWT_SECRET = process.env.JWT_SECRET || "supersecret";

export const registerUser = async (req: Request, res: Response) => {
  const parseResult = registerSchema.safeParse(req.body);

  if (!parseResult.success) {
    return res.status(422).json({
      success: false,
      message: "Validation failed",
      errors: parseResult.error.flatten().fieldErrors,
    });
  }
    
  const { name, email, password, role = "caregiver" } = parseResult.data;

  try {
    const existingUser = await db
      .select().from(users)
      .where(eq(users.email, email))
      .limit(1);

    if (existingUser.length > 0) {
      return res.status(409).json({
        success: false,
        message: "User with this email already exists.",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 12);

    const inserted = await db
      .insert(users)
      .values({
        name,
        email,
        passwordHash: hashedPassword,
        role,
        createdAt: new Date(),
        updatedAt: new Date(),
      })
      .returning({ id: users.id });
    
    const userId = inserted[0]?.id;
    if (!userId) {
      return res.status(500).json({
        success: false,
        message: "User ID not returned after insertion.",
      });
    }

    const token = jwt.sign(
      { userId, email, role },
      JWT_SECRET,
      { expiresIn: "30d" }
    );

    res.status(201).json({
      success: true,
      message: "User registered successfully.",
      user: { id: userId, name, email, role },
      token,
    });
  } catch (err: any) {
    console.error("Registration Error:", err);
    res.status(500).json({
      success: false,
      message: "Internal server error during registration.",
    });
  }
};
