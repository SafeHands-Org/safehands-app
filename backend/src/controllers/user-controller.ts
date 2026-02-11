import { Request, Response } from "express";
import { db } from "../db";
import { users } from "../db/schema";

// Get all users
export const getAllUsers = async (_req: Request, res: Response) => {
  try {
    const allUsers = await db.select().from(users);
    res.status(200).json(allUsers);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch users" });
  }
};

// Get users by role
export const getUsersByRole = async (req: Request, res: Response) => {
};

// Get user by ID
export const getUserById = async (req: Request, res: Response) => {
};