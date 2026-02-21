import { Request, Response } from "express";
import { db } from "../db";
import { eq } from "drizzle-orm";
import { users } from "../db/schema/users"

// GET all users
export const getAllUsers = async (req: Request, res: Response) => {
};

// GET user by ID
export const getUserById = async (req: Request, res: Response) => {
};

// GET users by role (caregiver only)
export const getUsersByRole = async (req: Request, res: Response) => {
};