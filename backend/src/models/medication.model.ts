import { stat } from "node:fs";
import { z } from "zod";

const uuid    = z.uuid();

const dayEnum = z.enum([
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
  "Sun",
]);

const statusEnum = z.enum(["taken", "missed"]);

export const NewMedication = z.object({
  names:        z.array(z.string()),
  doseForm:     z.string().min(1),
  dosage:       z.string().min(1),
  instructions: z.string().min(1),
  rxcui:        z.string().optional(),
});

export const NewFamilyMemberMedication = z.object({
  medicationId:   uuid.nonoptional(),
  familyMemberId: uuid.nonoptional(),
  priority:       z.enum(["high", "medium", "low"]).nonoptional(),
  quantity:       z.int().gt(0).nonoptional(),
  active:         z.boolean().nonoptional(),
});

export const NewSchedule = z.object({
  familyMemberMedicationId: uuid.nonoptional(),
  timesOfDay:  z.array(z.string()).min(1),
  frequency:  z.int().min(1),
  daysOfWeek: z.array(dayEnum).optional(),
});

export const NewAdherenceLog = z.object({
  familyMemberMedicationId: uuid.nonoptional(),
  scheduledTime: z.coerce.string().min(1).nonoptional(),
  takenAt:       z.coerce.date().nullable().optional(),
  status:        statusEnum.nonoptional(),
  recordedBy:    uuid,
});

export type  NewFamilyMemberMedication = z.infer<typeof NewFamilyMemberMedication>;
export type  NewMedication = z.infer<typeof NewMedication>;
export type  NewAdherenceLog = z.infer<typeof NewAdherenceLog>;
export type  NewSchedule = z.infer<typeof NewSchedule>;

export const UpdateAdherenceLog = z.object({
  scheduledTime: z.coerce.string().min(1).nonoptional(),
  takenAt:       z.coerce.date().nullable().optional(),
  status:        statusEnum.nonoptional(),
  recordedBy:    uuid,
});

export const UpdateMedication = z.object({
  doseForm:     z.string().min(1),
  dosage:       z.string().min(1),
  instructions: z.string().min(1),
});

export const UpdateFamilyMemberMedication = z.object({
  priority:       z.enum(["high", "medium", "low"]).nonoptional(),
  quantity:       z.int().gt(0).nonoptional(),
  active:         z.boolean().nonoptional(),
});

export const UpdateSchedule = z.object({
  timesOfDay:  z.array(z.string()).min(1),
  frequency:  z.int().min(1),
  daysOfWeek: z.array(dayEnum).optional()
});

export type  UpdateFamilyMemberMedication = z.infer<typeof UpdateFamilyMemberMedication>;
export type  UpdateMedication = z.infer<typeof UpdateMedication>;
export type  UpdateAdherenceLog = z.infer<typeof UpdateAdherenceLog>;
export type  UpdateSchedule = z.infer<typeof UpdateSchedule>;