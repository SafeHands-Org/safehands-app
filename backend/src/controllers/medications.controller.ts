import { Request, Response } from "express";
import * as service from "../services/medication.service";
import * as throwErr from "../utils/error.handling";

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

export const getMedicationById = async (
  req: Request<{ id: string }>,
  res: Response
) => {
  const med = await service.getMedicationById(req.params.id);

  if (!med) return throwErr.notFound("Medication not found");

  if (med.createdBy !== req.user.userId) {
    return throwErr.forbidden("Not authorized");
  }

  res.json(med);
};

export const updateMedication = async (
  req: Request<{ id: string }>,
  res: Response
) => {
  const med = await service.getMedicationById(req.params.id);

  if (!med) return throwErr.notFound("Medication not found");

  const canEdit =
    med.createdBy === req.user.userId ||
    req.permissions?.canEditMedications === true;

  if (!canEdit) {
    return throwErr.forbidden("No edit permissions");
  }

  const updated = await service.updateMedication(req.params.id, req.body);

  res.json(updated);
};

export const deleteMedication = async (
  req: Request<{ id: string }>,
  res: Response
) => {
  const med = await service.getMedicationById(req.params.id);

  if (!med) return throwErr.notFound("Medication not found");

  const canEdit =
    med.createdBy === req.user.userId ||
    req.permissions?.canEditMedications === true;

  if (!canEdit) {
    return throwErr.forbidden("No delete permissions");
  }

  await service.deleteMedication(req.params.id);
  res.status(204).send();
};