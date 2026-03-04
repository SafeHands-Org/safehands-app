import { z } from "zod";
import { Request, Response, NextFunction } from "express";

const doseFormEnum = [
  "tablet",
  "capsule",
  "liquid",
  "inhaler",
  "injection",
  "topical",
  "drops",
  "patch",
  "suppository",
  "other",
] as const;

const medicationSchema = z.object({
  nameEntered: z.string().min(1),
  doseForm: z.enum(doseFormEnum),
  dosage: z.string().optional(),
  instructions: z.string().optional(),
  rxcui: z.string().optional(),
});

export const validateMedication = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const result = medicationSchema.safeParse(req.body);

  if (!result.success) {
    return res.status(400).json({
      message: "Invalid medication input",
      errors: result.error.format(),
    });
  }

  req.body = result.data;
  next();
};