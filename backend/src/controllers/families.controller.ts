import { Request, Response } from "express";
import * as service from "../services/family.service";
import * as throwErr from "../utils/error.handling";
import { Family, Memberships, Invitation, CreateInvitation } from "../db/types";
import { getParam } from "../middleware/auth.middleware";

export const getFamilies = async (req: Request, res: Response) => {
  const userId = req.user!.id;
  const userRole = req.user!.role;
  if (userRole === 'caregiver') {
    const families = await service.getAdminFamilies(userId);
    return res.status(200).json(families);
  }
  const family = await service.getUserFamily(userId);
  if (!family) return res.status(200).json([]);
  return res.status(200).json([family]);
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
  const userId = req.user?.id;
  const userRole = req.user?.role;

  if (userRole == 'caregiver' && userId != null) {
    const members = await service.getAdminMemberships(userId);
    return res.status(200).json(members);
  }
  else if (userId != null && userRole != 'caregiver'){
    const userFamily = await service.getUserFamily(userId);
    if (!userFamily) return res.status(200).json([]);
    const members = await service.getUserMemberships(userFamily.family.id);
    return res.status(200).json(members);
  }
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

export const getInvitation = async (req: Request, res: Response) => {
  if (!req.user) return throwErr.unauthorized("Not authenticated");
  const userRole = req.user!.role;

  if (userRole === 'caregiver') {
    const existing = await service.getInvitation(req.user.id)

    if (existing != null) return res.status(201).json(existing);
    const result = await service.createInvitation(req.user.id);
    return res.status(201).json(result);
  }
};

export const addFamilyMember = async (req: Request, res: Response) => {
  if (!req.user) return throwErr.unauthorized("Not authenticated");

  const joinCode = req.body.joinCode;

  if (!joinCode) {
    return throwErr.badRequest("Join code is required");
  }

  const result = await service.joinFamily(joinCode, req.user.id);

  if (!result) {
    return throwErr.notFound("Invalid or expired join code");
  }

  return res.status(201).json(result);
};