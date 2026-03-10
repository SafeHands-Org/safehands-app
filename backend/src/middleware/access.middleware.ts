import { Request, Response, NextFunction } from "express";

import { getFamilyMembership } from "../services/family.service";
import * as throwErr from "../utils/error.handling";

declare module "express-serve-static-core" {
  interface Request {
    familyId?: string;
    membership?: {
      familyId: string;
      userId: string;
      isAdmin: boolean;
    };
    permissions?: {
      isAdmin: boolean;
      canEditMedications: boolean;
    };
  }
}

interface AccessOptions {
  requireFamily?: boolean;
}

export const accessMiddleware = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!req.user) return throwErr.unauthorized("User not authenticated");

  const isCaregiver = req.user.role === "caregiver";

  //familyId exists: resolve full membership
  const familyId = (req.params as { familyId?: string }).familyId;
  if (familyId) {
    const membership = await getFamilyMembership(req.user.userId, familyId);
    if (!membership) return throwErr.forbidden("Not part of this family");

    req.familyId = familyId;
    req.membership = {
      familyId: membership.familyId,
      userId: membership.userId,
      isAdmin: membership.is_admin,
    };

    const isAdmin = isCaregiver || membership.is_admin;
    req.permissions = { isAdmin, canEditMedications: isAdmin };
    return next();
  }

  //no familyId: set permissions based on role only
  req.permissions = {
    isAdmin: isCaregiver,
    canEditMedications: isCaregiver,
  };

  next();
};

//for routes that explicitly require a family context
export const requireFamilyAccess = (options: AccessOptions = {}) => {
  return async (
    req: Request<{ familyId?: string }>,
    res: Response,
    next: NextFunction
  ) => {
    if (!req.user) return throwErr.unauthorized("User not authenticated");

    const familyId = req.params.familyId;

    if (options.requireFamily || familyId) {
      if (!familyId) return throwErr.badRequest("Family ID required");

      const membership = await getFamilyMembership(req.user.userId, familyId);
      if (!membership) return throwErr.forbidden("Not part of this family");

      req.familyId = familyId;
      req.membership = {
        familyId: membership.familyId,
        userId: membership.userId,
        isAdmin: membership.is_admin,
      };

      const isAdmin =
        req.user.role === "caregiver" || membership.is_admin;
      req.permissions = { isAdmin, canEditMedications: isAdmin };
    }

    next();
  };
};