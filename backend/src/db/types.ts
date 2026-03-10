import { type InferSelectModel, type InferEnum } from "drizzle-orm";
import { users, userRoleEnum } from "../db/schema/users";
import { familyMemberships } from "../db/schema/families";
import { sessionsTable } from "../db/schema/sessions";
import { medications, familyMemberMedications, medicationSchedules, medicationAdherenceLogs } from "../db/schema/medications";

export type User = InferSelectModel<typeof users>;
export type UserRole = InferEnum<typeof userRoleEnum>;
export type Session = Pick<InferSelectModel<typeof sessionsTable>, "userId" | "sessionToken" | "expiresAt">;
export type TokenPayload = Pick<InferSelectModel<typeof users>, "id" | "role">;
export type Memberships = InferSelectModel<typeof familyMemberships>;

export type DoseForm =
  | "tablet"
  | "capsule"
  | "liquid"
  | "inhaler"
  | "injection"
  | "topical"
  | "drops"
  | "patch"
  | "suppository"
  | "other";

export type Medication = InferSelectModel<typeof medications> & {
  doseForm: DoseForm;
};

export type FamilyMemberMedication = InferSelectModel<typeof familyMemberMedications>;
export type MedicationSchedule = InferSelectModel<typeof medicationSchedules>;
export type MedicationAdherenceLog = InferSelectModel<typeof medicationAdherenceLogs>;