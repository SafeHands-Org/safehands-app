import { Request, Response } from "express";
import * as throwErr from "../utils/error.handling"

export const getDashboard = async (req: Request, res: Response) => {
  // Build dashboard based on req.user.role
};