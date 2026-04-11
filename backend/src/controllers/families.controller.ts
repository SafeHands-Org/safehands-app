import { Request, Response } from "express";
import * as service from "../services/family.service";
import * as throwErr from "../utils/error.handling";
import { Family, Memberships, Invitation } from "../db/types";
import { getParam } from "../middleware/auth.middleware";

export const getFamilies = async (req: Request, res: Response) => {
  const userId = req.user!.id;
  const userRole = req.user!.role;

  if (userRole == 'caregiver') {
    const families = await service.getAdminFamilies(userId);
    return res.status(200).json(families);
  }

  const family = await service.getUserFamily(userId);
  return res.status(200).json(family);
};

export const createFamily = async (req: Request, res: Response) => {
  const userId = req.user?.id;
  const data: Family = {
    ...req.body,
    createdBy: userId,
  };

  const result = await service.createFamily(data);
  return res.status(201).json(result);
};

export const getFamilyById = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  const family = await service.getFamilyById(id);

  return res.status(200).json(family);
};

export const updateFamily = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  const data = req.body;

  const result = await service.updateFamily(id, data);
  return res.status(200).json(result);
};

export const deleteFamily = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "id");
  await service.deleteFamily(id);
  return res.status(204).send();
};

export const getFamilyMembers = async (req: Request, res: Response) => {
  const userId = req.user!.id;
  const userRole = req.user!.role;

  if (userRole == 'caregiver') {
    const members = await service.getAdminMemberships(userId);
    return res.status(200).json(members);
  }

  const members = await service.getUserMemberships(userId);
  return res.status(200).json(members);
};

export const addFamilyMember = async (req: Request, res: Response) => {
  const data: Memberships = req.body;
  const result = await service.addFamilyMember(data);
  return res.status(201).json(result);
};

export const updateFamilyMember = async (req: Request, res: Response) => {
  const memberId = getParam(req.params.fmId, "fmId");
  const data = req.body;

  const result = await service.updateFamilyMember(memberId, data);
  return res.status(200).json(result);
};

export const removeFamilyMember = async (req: Request, res: Response) => {
  const memberId = getParam(req.params.fmId, "fmId");
  await service.removeFamilyMember(memberId);
  return res.status(204).send();
};

export const createInvitation = async (req: Request, res: Response) => {
  const userId = req.user!.id;

  const data: Invitation = {
    ...req.body,
    createdBy: userId,
  };

  const result = await service.createInvitation(data);
  return res.status(201).json(result);
};

export const checkInvitation = async (req: Request, res: Response) => {
  const token = getParam(req.params.token, "token");
  const invitation = await service.checkInvitation(token);
  if (!invitation) return throwErr.notFound("Invitation not found");

  return res.status(200).json(invitation);
};