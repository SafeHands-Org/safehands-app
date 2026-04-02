import { z } from "zod";
import { Request, Response, NextFunction } from "express";

const isoDate = z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Must be yyyy-MM-dd");
const hhMm    = z.string().regex(/^\d{2}:\d{2}(:\d{2})?$/, "Must be HH:MM");
const isoTs   = z.string().refine(v => !isNaN(Date.parse(v)), "Must be a valid ISO timestamp");
const uuid    = z.uuid();

const medicationSchema = z.object({
  names:        z.array(z.string()),
  doseForm:     z.string().min(1),
  dosage:       z.string().min(1),
  instructions: z.string().min(1),
  rxcui:        z.string().min(1),
});

const familyMemberMedicationSchema = z.object({
  medicationId:   uuid,
  familyMemberId: uuid,
  active:         z.boolean().optional(),
});

const scheduleSchema = z.object({
  familyMemberMedicationId: uuid,
  timeOfDay:  z.array(hhMm),
  frequency:  z.int().min(10),
  daysOfWeek: z.array(z.string()).nullable().optional(),
});

const adherenceLogSchema = z.object({
  familyMemberMedicationId: uuid,
  scheduledTime: isoTs,
  takenAt:       isoTs.nullable().optional(),
  status:        z.enum(["taken", "missed", "skipped"]),
  recordedBy:    uuid,
});

const makeValidator = (postSchema: z.ZodTypeAny, putSchema: z.ZodTypeAny) =>
  (req: Request, res: Response, next: NextFunction) => {
    const schema = req.method === "PUT" ? putSchema : postSchema;
    const parsed = schema.safeParse(req.body);
    if (!parsed.success) {
      return res.status(400).json({ message: "Invalid input", errors: parsed.error.format() });
    }
    req.body = parsed.data;
    next();
  };

export const validateMedication = makeValidator(
  medicationSchema,
  medicationSchema.partial()
);

export const validateFamilyMemberMedication = makeValidator(
  familyMemberMedicationSchema,
  familyMemberMedicationSchema.partial()
);

export const validateSchedule = makeValidator(
  scheduleSchema,
  scheduleSchema.partial()
);

export const validateAdherenceLog = makeValidator(
  adherenceLogSchema,
  adherenceLogSchema.partial()
);