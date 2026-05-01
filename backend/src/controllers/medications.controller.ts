import { Request, Response } from "express";
import * as service from "../services/medication.service";
import * as throwErr from "../utils/error.handling";
import { Medication, FamilyMemberMedication, MedicationSchedule, MedicationAdherenceLog } from "../db/types";
import { getParam } from "../middleware/auth.middleware";

export const getMedications = async (req: Request, res: Response) => {
  const userId = req.user!.id;
  const meds = await service.getAllMedications(userId);
  res.status(200).json(meds);
};

export const createMedication = async (req: Request, res: Response) => {
  const userId = req.user!.id;

  const data: Medication = {
    ...req.body,
    createdBy: userId,
  };
  const result = await service.createMedication(data);
  res.status(201).json(result[0]);
};

export const getMedicationById = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  const med = await service.getMedicationById(id);
  if (!med) return throwErr.notFound("Medication not found");
  res.status(200).json(med);
};

export const updateMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  const data: Partial<Medication> = req.body;
  const result = await service.updateMedication(id, data);
  res.status(200).json(result[0]);
};

export const deleteMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  await service.deleteMedication(id);
  res.status(204).send();
};

export const getFamilyMemberMedications = async (req: Request, res: Response) => {
  const userId = req.user?.id;
  const userRole = req.user?.role;

  if (userRole == 'caregiver' && userId != null) {
    const result = await service.getCaregiverFamilyMedications(userId);
    return res.status(200).json(result);
  }
  else if (userRole != 'caregiver' && userId != null){
    const result = await service.getFamilyMemberMedications(userId);
    return res.status(200).json(result);
  }
};

export const assignMedicationToMember = async (req: Request, res: Response) => {
  const body = req.body;
  const result = await service.assignMedicationToMember(body);
  res.status(201).json(result);
};

export const updateFamilyMemberMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.fmmId, "fmmId");
  const data = req.body;
  const result = await service.updateFamilyMemberMedication(id, data);
  res.status(200).json(result);
};

export const removeFamilyMemberMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.fmmId, "fmmid");
  await service.removeFamilyMemberMedication(id);
  res.status(204).send();
};

export const getMedicationSchedules = async (req: Request, res: Response) => {
  const userId = req.user?.id;
  const userRole = req.user?.role;
  const fmmId = req.query.fmmId as string | undefined;

  if (fmmId) {
    const result = await service.getScheduleByFmmId(fmmId);
    if (!result) return res.status(200).json([]);
    return res.status(200).json([{ schedules: result }]);
  }

  if (userRole == 'caregiver' && userId != null) {
    const result = await service.getCaregiverMedicationSchedules(userId);
    return res.status(200).json(result);
  }
  else if (userRole != 'caregiver' && userId != null){
    const result = await service.getMemberMedicationSchedules(userId);
    return res.status(200).json(result);
  }
};

export const createMedicationSchedule = async (req: Request, res: Response) => {
  const data = req.body;
  const result = await service.createMedicationSchedule(data);
  res.status(201).json(result);
};

export const updateMedicationSchedule = async (req: Request, res: Response) => {
  const id = getParam(req.params.schedId, "schedId");
  const data = req.body;
  const result = await service.updateMedicationSchedule(id, data);
  res.status(200).json(result[0]);
};

export const deleteMedicationSchedule = async (req: Request, res: Response) => {
  const id = getParam(req.params.schedId, "schedId");
  await service.deleteMedicationSchedule(id);
  res.status(204).send();
};

export const getAdherenceLogs = async (req: Request, res: Response) => {
  const userId = req.user?.id;
  const userRole = req.user?.role;

  if (userRole == 'caregiver' && userId != null) {
    const result = await service.getCaregiverAdherenceLogs(userId);
    return res.status(200).json(result);
  }
  else if (userRole != 'caregiver' && userId != null){
    const result = await service.getMemberAdherenceLogs(userId);
    return res.status(200).json(result);
  }
};

export const createAdherenceLog = async (req: Request, res: Response) => {
  const data = req.body;
  const result = await service.createAdherenceLog(data);
  res.status(201).json(result[0]);
};

export const updateAdherenceLog = async (req: Request, res: Response) => {
  const id = getParam(req.params.logId, "logId");
  const data = req.body;
  const result = await service.updateAdherenceLog(id, data);
  res.status(200).json(result[0]);
};