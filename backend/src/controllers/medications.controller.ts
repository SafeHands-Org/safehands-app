import { Request, Response } from "express";
import * as service from "../services/medication.service";
import * as throwErr from "../utils/error.handling";
import { Medication, FamilyMemberMedication, MedicationSchedule, MedicationAdherenceLog } from "../db/types";
import { getParam } from "../middleware/auth.middleware";

export const getMedications = async (req: Request, res: Response) => {
  console.log("GET /medications hit");
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
  res.status(201).json(result);
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
  res.status(200).json(result);
};

export const deleteMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  await service.deleteMedication(id);
  res.status(204).send();
};

export const getFamilyMemberMedications = async (req: Request, res: Response) => {
  const id = req.user!.id;
  const meds = await service.getCaregiverFamilyMedications(id);
  res.status(200).json(meds);
};

export const assignMedicationToMember = async (req: Request, res: Response) => {
  const body = req.body;
  console.log({
    medicationId: body.medicationId,
    familyMemberId: body.familyMemberId,
    priority: body.priority,
    quantity: body.quantity,
    active: body.active,
  })
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
  const id = req.user!.id;
  const result = await service.getCaregiverMedicationSchedules(id);
  res.status(200).json(result);
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
  res.status(200).json(result);
};

export const deleteMedicationSchedule = async (req: Request, res: Response) => {
  const id = getParam(req.params.schedId, "schedId");
  await service.deleteMedicationSchedule(id);
  res.status(204).send();
};

export const getAdherenceLogs = async (req: Request, res: Response) => {
  const id = req.user!.id;
  const result = await service.getCaregiverAdherenceLogs(id);
  res.status(200).json(result);
};

export const createAdherenceLog = async (req: Request, res: Response) => {
  const data = req.body;
  const result = await service.createAdherenceLog(data);
  res.status(201).json(result);
};

export const updateAdherenceLog = async (req: Request, res: Response) => {
  const id = getParam(req.params.logId, "logId");
  const data = req.body;
  const result = await service.updateAdherenceLog(id, data);
  res.status(200).json(result);
};