import { Request, Response } from "express";
import * as throwErr from "../utils/error.handling"

export const getMedications = async (req: Request, res: Response) => {};
export const createMedication = async (req: Request, res: Response) => {};
export const getMedicationById = async (req: Request, res: Response) => {};
export const updateMedication = async (req: Request, res: Response) => {};
export const deleteMedication = async (req: Request, res: Response) => {};

export const getFamilyMemberMedications = async (req: Request, res: Response) => {};
export const assignMedicationToMember = async (req: Request, res: Response) => {};
export const updateFamilyMemberMedication = async (req: Request, res: Response) => {};
export const removeFamilyMemberMedication = async (req: Request, res: Response) => {};

export const getMedicationSchedules = async (req: Request, res: Response) => {};
export const createMedicationSchedule = async (req: Request, res: Response) => {};
export const updateMedicationSchedule = async (req: Request, res: Response) => {};
export const deleteMedicationSchedule = async (req: Request, res: Response) => {};

export const getAdherenceLogs = (req: Request, res: Response) => {};
export const createAdherenceLog = (req: Request, res: Response) => {};
export const updateAdherenceLog = (req: Request, res: Response) => {};