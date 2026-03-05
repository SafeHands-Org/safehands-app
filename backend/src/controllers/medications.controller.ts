import { Request, Response } from "express";
import * as service from "../services/medication.service";
import * as throwErr from "../utils/error.handling";

const getParam = (param: string | string[] | undefined): string => {
  if (!param) throw new Error("Missing route parameter");
  return Array.isArray(param) ? param[0] : param;
};

export const getMedications = async (req: Request, res: Response) => {
  const meds = await service.getAllMedications(req.user.userId);
  res.json(meds);
};

export const createMedication = async (req: Request, res: Response) => {
  const medication = await service.createMedication({
    ...req.body,
    createdBy: req.user.userId,
  });

  res.status(201).json(medication);
};

export const getMedicationById = async (req: Request, res: Response) => {
  const med = await service.getMedicationById(getParam(req.params.id));

  if (!med) return throwErr.notFound("Medication not found");
  if (med.createdBy !== req.user.userId)
    return throwErr.forbidden("Not authorized");
  res.json(med);
};

export const updateMedication = async (req: Request, res: Response) => {
  const med = await service.getMedicationById(getParam(req.params.id));
  if (!med) return throwErr.notFound("Medication not found");

  const canEdit =
    med.createdBy === req.user.userId ||
    req.permissions?.canEditMedications === true;

  if (!canEdit) return throwErr.forbidden("No edit permission");

  const updated = await service.updateMedication(getParam(req.params.id), req.body);
  res.json(updated);
};

export const deleteMedication = async (req: Request, res: Response) => {
  const med = await service.getMedicationById(getParam(req.params.id));
  if (!med) return throwErr.notFound("Medication not found");

  const canEdit =
    med.createdBy === req.user.userId ||
    req.permissions?.canEditMedications === true;

  if (!canEdit) return throwErr.forbidden("No delete permission");

  await service.deleteMedication(getParam(req.params.id));
  res.status(204).send();
};

export const getFamilyMemberMedications = async (req: Request, res: Response) => {
  const meds = await service.getFamilyMemberMedications(getParam(req.params.memberId));
  res.json(meds);
};

export const assignMedicationToMember = async (req: Request, res: Response) => {
  const canEdit = req.permissions?.canEditMedications === true;
  if (!canEdit) return throwErr.forbidden("No assignment permission");

  const result = await service.assignMedicationToMember(req.body);
  res.status(201).json(result);
};

export const updateFamilyMemberMedication = async (req: Request, res: Response) => {
  const canEdit = req.permissions?.canEditMedications === true;
  if (!canEdit) return throwErr.forbidden("No update permission");

  const result = await service.updateFamilyMemberMedication(
    getParam(req.params.id),
    req.body
  );

  res.json(result);
};

export const removeFamilyMemberMedication = async (req: Request, res: Response) => {
  const canEdit = req.permissions?.canEditMedications === true;
  if (!canEdit) return throwErr.forbidden("No removal permission");

  await service.removeFamilyMemberMedication(getParam(req.params.id));
  res.status(204).send();
};


export const getMedicationSchedules = async (req: Request, res: Response) => {
  const schedules = await service.getMedicationSchedules(getParam(req.params.id));
  res.json(schedules);
};

export const createMedicationSchedule = async (req: Request, res: Response) => {
  const canEdit = req.permissions?.canEditMedications === true;
  if (!canEdit) return throwErr.forbidden("No schedule creation permission");

  const result = await service.createMedicationSchedule(req.body);
  res.status(201).json(result);
};

export const updateMedicationSchedule = async (req: Request, res: Response) => {
  const canEdit = req.permissions?.canEditMedications === true;
  if (!canEdit) return throwErr.forbidden("No schedule update permission");

  const result = await service.updateMedicationSchedule(
    getParam(req.params.id),
    req.body
  );

  res.json(result);
};

export const deleteMedicationSchedule = async (req: Request, res: Response) => {
  const canEdit = req.permissions?.canEditMedications === true;
  if (!canEdit) return throwErr.forbidden("No schedule deletion permission");

  await service.deleteMedicationSchedule(getParam(req.params.id));
  res.status(204).send();
};

export const getAdherenceLogs = async (req: Request, res: Response) => {
  const logs = await service.getAdherenceLogs(getParam(req.params.id));
  res.json(logs);
};

export const createAdherenceLog = async (req: Request, res: Response) => {
  const result = await service.createAdherenceLog(req.body);
  res.status(201).json(result);
};

export const updateAdherenceLog = async (req: Request, res: Response) => {
  const result = await service.updateAdherenceLog(
    getParam(req.params.id),
    req.body
  );

  res.json(result);
};