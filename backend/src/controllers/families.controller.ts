import { Request, Response } from "express";
import * as service from "../services/family.service";
import * as throwErr from "../utils/error.handling";
import { CreateFamilyBody } from "../models/families.model";
import { Family, Memberships, Invitation } from "../db/types";

const getParam = (param: string | string[], name = "parameter"): string => {
  if (!param) throwErr.badRequest(`Missing ${name}`);
  return Array.isArray(param) ? param[0] : param;
};

const getReqUser = (req: Request) => ({
  userId: (req.user as any)?.id || (req.user as any)?.userId,
  role: (req.user as any)?.role,
});

export const getUserFamilies = async (req: Request, res: Response) => {
  try {
    const { userId } = getReqUser(req);

    if (!userId) {
      return res.status(401).json({ message: "Unauthorized" });
    }

    const families = await service.getUserFamilies(userId);
    return res.json(families);
  } catch (error) {
    return res.status(500).json({ message: "Failed to fetch user families" });
  }
};

export const createFamily = async (req: Request, res: Response) => {
  const { userId } = getReqUser(req);
  if (!userId) return throwErr.unauthorized("No user");

  CreateFamilyBody.parse(req.body);

  const data: Family = {
    ...req.body,
    createdBy: userId,
  };

  const result = await service.createFamily(data);
  return res.status(201).json(result);
};

export const getFamilyById = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "family id");
  const family = await service.getFamilyById(id);
  if (!family) return throwErr.notFound("Family not found");

  return res.json(family);
};

export const updateFamily = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "family id");
  const data: Partial<Family> = req.body;

  const result = await service.updateFamily(id, data);
  return res.json(result);
};

export const deleteFamily = async (req: Request, res: Response) => {
  const id = getParam(req.params.id, "family id");
  await service.deleteFamily(id);
  return res.status(204).send();
};

export const addFamilyMember = async (req: Request, res: Response) => {
  const data: Memberships = req.body;
  const result = await service.addFamilyMember(data);
  return res.status(201).json(result);
};

export const updateFamilyMember = async (req: Request, res: Response) => {
  const memberId = getParam(req.params.memberId, "family membership id");
  const data: Partial<Memberships> = req.body;

  const result = await service.updateFamilyMember(memberId, data);
  return res.json(result);
};

export const removeFamilyMember = async (req: Request, res: Response) => {
  const memberId = getParam(req.params.memberId, "family membership id");
  await service.removeFamilyMember(memberId);
  return res.status(204).send();
};

export const createInvitation = async (req: Request, res: Response) => {
  const { userId } = getReqUser(req);
  if (!userId) return throwErr.unauthorized("No user");

  const data: Invitation = {
    ...req.body,
    createdBy: userId,
  };

  const result = await service.createInvitation(data);
  return res.status(201).json(result);
};

export const checkInvitation = async (req: Request, res: Response) => {
  const token = getParam(req.params.token, "invitation token");
  const invitation = await service.checkInvitation(token);
  if (!invitation) return throwErr.notFound("Invitation not found");

  return res.json(invitation);
};

export const acceptInvitation = async (req: Request, res: Response) => {
  const { userId } = getReqUser(req);
  if (!userId) return throwErr.unauthorized("No user");

  const token = getParam(req.params.token, "invitation token");
  const result = await service.acceptInvitation(token, userId);
  return res.json(result);
};