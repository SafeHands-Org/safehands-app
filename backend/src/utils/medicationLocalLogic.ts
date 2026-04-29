import * as throwErr from "./error.handling";
import { DoseForm } from "../db/types";

export interface MedicationInput {
  nameEntered: string;
  doseForm: DoseForm;
  rxcui?: string | null;
  dosage?: string | null;
  instructions?: string | null;
}

const DOSE_FORMS: DoseForm[] = [
  "tablet", "capsule", "liquid", "inhaler", "injection",
  "topical", "drops", "patch", "suppository", "other",
];

export const validateMedicationInput = (
  input: Partial<MedicationInput>,
  isUpdate = false
): MedicationInput => {
  if (!isUpdate && !input.nameEntered?.trim()) {
    throwErr.badRequest("Medication name is required");
  }
  if (input.doseForm && !DOSE_FORMS.includes(input.doseForm)) {
    throwErr.badRequest(`Invalid dose form. Must be one of: ${DOSE_FORMS.join(", ")}`);
  }
  return {
    nameEntered:  input.nameEntered?.trim() ?? "",
    doseForm:     input.doseForm ?? "other",
    rxcui:        input.rxcui    ?? null,
    dosage:       input.dosage   ?? null,
    instructions: input.instructions ?? null,
  };
};

export interface FamilyMemberMedicationInput {
  medicationId: string;
  familyMemberId: string;
  startDate: string;
  endDate?: string | null;
  active?: boolean;
}

const ISO_DATE = /^\d{4}-\d{2}-\d{2}$/;

export const validateFamilyMemberMedicationInput = (
  input: Partial<FamilyMemberMedicationInput>,
  isUpdate = false
): FamilyMemberMedicationInput => {
  if (!isUpdate) {
    if (!input.medicationId)   throwErr.badRequest("medicationId is required");
    if (!input.familyMemberId) throwErr.badRequest("familyMemberId is required");
    if (!input.startDate)      throwErr.badRequest("startDate is required");
  }
  if (input.startDate && !ISO_DATE.test(input.startDate)) {
    throwErr.badRequest("startDate must be in yyyy-MM-dd format");
  }
  if (input.endDate && !ISO_DATE.test(input.endDate)) {
    throwErr.badRequest("endDate must be in yyyy-MM-dd format");
  }
  if (input.endDate && input.startDate && input.endDate < input.startDate) {
    throwErr.badRequest("endDate cannot be before startDate");
  }
  return {
    medicationId:   input.medicationId   ?? "",
    familyMemberId: input.familyMemberId ?? "",
    startDate:      input.startDate      ?? "",
    endDate:        input.endDate        ?? null,
    active:         input.active         ?? true,
  };
};

export interface ScheduleInput {
  familyMemberMedicationId: string;
  timeOfDay: string;
  daysOfWeek?: string | null;
  frequency: string;
}

const FREQUENCIES = ["daily", "weekly", "specific_days", "as_needed"] as const;
const HH_MM = /^\d{2}:\d{2}(:\d{2})?$/;

export const validateScheduleInput = (
  input: Partial<ScheduleInput>,
  isUpdate = false
): ScheduleInput => {
  if (!isUpdate) {
    if (!input.familyMemberMedicationId) throwErr.badRequest("familyMemberMedicationId is required");
    if (!input.timeOfDay)                throwErr.badRequest("timeOfDay is required");
    if (!input.frequency)                throwErr.badRequest("frequency is required");
  }
  if (input.timeOfDay && !HH_MM.test(input.timeOfDay)) {
    throwErr.badRequest("timeOfDay must be in HH:MM format");
  }
  if (input.frequency && !FREQUENCIES.includes(input.frequency as any)) {
    throwErr.badRequest(`frequency must be one of: ${FREQUENCIES.join(", ")}`);
  }
  return {
    familyMemberMedicationId: input.familyMemberMedicationId ?? "",
    timeOfDay:  input.timeOfDay  ?? "",
    daysOfWeek: input.daysOfWeek ?? null,
    frequency:  input.frequency  ?? "",
  };
};

export interface AdherenceLogInput {
  familyMemberMedicationId: string;
  scheduledTime: string;
  takenAt?: string | null;
  status: string;
  recordedBy: string;
}

const STATUSES = ["taken", "missed", "skipped"] as const;

export const validateAdherenceLogInput = (
  input: Partial<AdherenceLogInput>,
  isUpdate = false
): AdherenceLogInput => {
  if (!isUpdate) {
    if (!input.familyMemberMedicationId) throwErr.badRequest("familyMemberMedicationId is required");
    if (!input.scheduledTime)            throwErr.badRequest("scheduledTime is required");
    if (!input.status)                   throwErr.badRequest("status is required");
    if (!input.recordedBy)               throwErr.badRequest("recordedBy is required");
  }
  if (input.scheduledTime && isNaN(Date.parse(input.scheduledTime))) {
    throwErr.badRequest("scheduledTime must be a valid ISO 8601 timestamp");
  }
  if (input.takenAt && isNaN(Date.parse(input.takenAt))) {
    throwErr.badRequest("takenAt must be a valid ISO 8601 timestamp");
  }
  if (input.status && !STATUSES.includes(input.status as any)) {
    throwErr.badRequest(`status must be one of: ${STATUSES.join(", ")}`);
  }
  return {
    familyMemberMedicationId: input.familyMemberMedicationId ?? "",
    scheduledTime: input.scheduledTime ?? "",
    takenAt:       input.takenAt       ?? null,
    status:        input.status        ?? "",
    recordedBy:    input.recordedBy    ?? "",
  };
};