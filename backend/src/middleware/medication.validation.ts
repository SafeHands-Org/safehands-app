import { z } from "zod";
import { Request, Response, NextFunction } from "express";

const isoDate = z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Must be yyyy-MM-dd");
const hhMm    = z.string().regex(/^\d{2}:\d{2}(:\d{2})?$/, "Must be HH:MM");
const isoTs   = z.string().refine(v => !isNaN(Date.parse(v)), "Must be a valid ISO timestamp");
const uuid    = z.string().uuid();

const medicationSchema = z.object({
  nameEntered:  z.string().min(1),
  doseForm:     z.enum(["tablet","capsule","liquid","inhaler","injection","topical","drops","patch","suppository","other"]),
  dosage:       z.string().optional(),
  instructions: z.string().optional(),
  rxcui:        z.string().optional(),
});

const familyMemberMedicationBase = z.object({
  medicationId:   uuid,
  familyMemberId: uuid,
  startDate:      isoDate,
  endDate:        isoDate.nullable().optional(),
  active:         z.boolean().optional(),
});
const familyMemberMedicationSchema = familyMemberMedicationBase.refine(
  d => !d.endDate || d.endDate >= d.startDate,
  { message: "endDate cannot be before startDate", path: ["endDate"] }
);

const scheduleSchema = z.object({
  familyMemberMedicationId: uuid,
  timeOfDay:  hhMm,
  frequency:  z.enum(["daily", "weekly", "specific_days", "as_needed"]),
  daysOfWeek: z.string().nullable().optional(),
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
  familyMemberMedicationBase.partial()
);

export const validateSchedule = makeValidator(
  scheduleSchema,
  scheduleSchema.partial()
);

export const validateAdherenceLog = makeValidator(
  adherenceLogSchema,
  adherenceLogSchema.partial()
);