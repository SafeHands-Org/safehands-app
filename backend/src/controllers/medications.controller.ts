import { Request, Response } from "express";
import { db } from "../db";
import {medications, familyMemberMedications} from "../db/schema";

// Create medication
export const createMedication = async (req: Request, res: Response) => {
};

// Assign medication to family member
export const assignMedication = async (req: Request, res: Response) => {
};

// Add medication schedule
export const addMedicationSchedule = async (req: Request, res: Response) => {
};

// Get medications for a family member
export const getMedicationsForFamilyMember = async (req: Request, res: Response
) => {};