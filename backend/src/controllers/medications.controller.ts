import { Request, Response } from "express";
import * as service from "../services/medication.service";
import * as throwErr from "../utils/error.handling";
import { Medication, FamilyMemberMedication, MedicationSchedule, MedicationAdherenceLog } from "../db/types";

const getParam = (param: string | string[], name = "parameter"): string => {
  if (!param) throwErr.badRequest(`Missing ${name}`);
  return Array.isArray(param) ? param[0] : param;
};

export const getMedications = async (req: Request, res: Response) => {
  console.log("GET /medications hit");
  const userId = req.user?.id;
  if (!userId) return throwErr.unauthorized("No user");
  const meds = await service.getAllMedications(userId);
  res.json(meds);
};

export const createMedication = async (req: Request, res: Response) => {
  const userId = req.user?.id;
  if (!userId) return throwErr.unauthorized("No user");

  const data: Medication = {
    ...req.body,
    createdBy: userId,
  };
  const result = await service.createMedication(data);
  res.status(201).json(result);
};

export const getMedicationById = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "medication id");
  const med = await service.getMedicationById(id);
  if (!med) return throwErr.notFound("Medication not found");
  res.json(med);
};

export const updateMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "medication id");
  const data: Partial<Medication> = req.body;
  const result = await service.updateMedication(id, data);
  res.json(result);
};

export const deleteMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "medication id");
  await service.deleteMedication(id);
  res.status(204).send();
};

export const getFamilyMemberMedications = async (req: Request, res: Response) => {
  const memberId = getParam(req.params.memberId, "member id");
  const meds = await service.getFamilyMemberMedications(memberId);
  res.json(meds);
};

export const assignMedicationToMember = async (req: Request, res: Response) => {
  const data: FamilyMemberMedication = req.body;
  const result = await service.assignMedicationToMember(data);
  res.status(201).json(result);
};

export const updateFamilyMemberMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "family member medication id");
  const data: Partial<FamilyMemberMedication> = req.body;
  const result = await service.updateFamilyMemberMedication(id, data);
  res.json(result);
};

export const removeFamilyMemberMedication = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "family member medication id");
  await service.removeFamilyMemberMedication(id);
  res.status(204).send();
};

export const getMedicationSchedules = async (req: Request, res: Response) => {
  const fmmId = getParam(req.params.id, "family member medication id");
  const schedules = await service.getMedicationSchedules(fmmId);
  res.json(schedules);
};

export const createMedicationSchedule = async (req: Request, res: Response) => {
  const data: MedicationSchedule = req.body;
  const result = await service.createMedicationSchedule(data);
  res.status(201).json(result);
};

export const updateMedicationSchedule = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "schedule id");
  const data: Partial<MedicationSchedule> = req.body;
  const result = await service.updateMedicationSchedule(id, data);
  res.json(result);
};

export const deleteMedicationSchedule = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "schedule id");
  await service.deleteMedicationSchedule(id);
  res.status(204).send();
};

export const getAdherenceLogs = async (req: Request, res: Response) => {
  const fmmId = getParam(req.params.id, "family member medication id");
  const logs = await service.getAdherenceLogs(fmmId);
  res.json(logs);
};

export const createAdherenceLog = async (req: Request, res: Response) => {
  const data: MedicationAdherenceLog = req.body;
  const result = await service.createAdherenceLog(data);
  res.status(201).json(result);
};

export const updateAdherenceLog = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "adherence log id");
  const data: Partial<MedicationAdherenceLog> = req.body;
  const result = await service.updateAdherenceLog(id, data);
  res.json(result);
};