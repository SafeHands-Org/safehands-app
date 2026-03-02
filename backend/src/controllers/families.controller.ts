import { Request, Response } from "express";
import * as throwErr from "../utils/error.handling"

export const getUserFamilies = async (req: Request, res: Response) => {};

export const createFamily = async (req: Request, res: Response) => {};
export const getFamilyById = async (req: Request, res: Response) => {};
export const updateFamily = async (req: Request, res: Response) => {};
export const deleteFamily = async (req: Request, res: Response) => {};

export const addFamilyMember = async (req: Request, res: Response) => {};
export const updateFamilyMember = async (req: Request, res: Response) => {};
export const removeFamilyMember = async (req: Request, res: Response) => {};

export const createInvitation = async (req: Request, res: Response) => {};
export const checkInvitation = async (req: Request, res: Response) => {};
export const acceptInvitation = async (req: Request, res: Response) => {};