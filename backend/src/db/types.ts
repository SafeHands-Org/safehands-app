import { type InferEnum, type InferSelectModel } from "drizzle-orm";
import { families, familyMemberships, invitations } from "../db/schema/families";
import { familyMemberMedications, medicationAdherenceLogs, medications, medicationSchedules } from "../db/schema/medications";
import { sessionsTable } from "../db/schema/sessions";
import { userRoleEnum, users } from "../db/schema/users";

export type User = InferSelectModel<typeof users>;
export type UserRole = InferEnum<typeof userRoleEnum>;
export type Session = Pick<InferSelectModel<typeof sessionsTable>, "userId" | "sessionToken" | "expiresAt">;
export type TokenPayload = Pick<InferSelectModel<typeof users>, "id" | "role">;
export type Memberships = InferSelectModel<typeof familyMemberships>;
export type Family = InferSelectModel<typeof families>;
export type Invitation = InferSelectModel<typeof invitations>;
export type Medication = InferSelectModel<typeof medications>;
export type FamilyMemberMedication = InferSelectModel<typeof familyMemberMedications>;
export type MedicationSchedule = InferSelectModel<typeof medicationSchedules>;
export type MedicationAdherenceLog = InferSelectModel<typeof medicationAdherenceLogs>;