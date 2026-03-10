import { db } from "../db";
import { medications, familyMemberMedications, medicationSchedules, medicationAdherenceLogs } from "../db/schema/medications";
import { eq } from "drizzle-orm";
import { Medication, FamilyMemberMedication, MedicationSchedule, MedicationAdherenceLog } from "../db/types";

export const getAllMedications = (userId: string) =>
  db.select().from(medications).where(eq(medications.createdBy, userId));

export const createMedication = (data: Medication) =>
  db.insert(medications).values(data).returning();

export const getMedicationById = (id: string) =>
  db.select().from(medications).where(eq(medications.id, id)).then(r => r[0] ?? null);

export const updateMedication = (id: string, data: Partial<Medication>) =>
  db.update(medications).set(data).where(eq(medications.id, id)).returning();

export const deleteMedication = (id: string) =>
  db.delete(medications).where(eq(medications.id, id));

export const getFamilyMemberMedications = (memberId: string) =>
  db.select().from(familyMemberMedications).where(eq(familyMemberMedications.familyMemberId, memberId));

export const assignMedicationToMember = (data: FamilyMemberMedication) =>
  db.insert(familyMemberMedications).values(data).returning();

export const updateFamilyMemberMedication = (id: string, data: Partial<FamilyMemberMedication>) =>
  db.update(familyMemberMedications).set(data).where(eq(familyMemberMedications.id, id)).returning();

export const removeFamilyMemberMedication = (id: string) =>
  db.delete(familyMemberMedications).where(eq(familyMemberMedications.id, id));

export const getMedicationSchedules = (fmmId: string) =>
  db.select().from(medicationSchedules).where(eq(medicationSchedules.familyMemberMedicationId, fmmId));

export const createMedicationSchedule = (data: MedicationSchedule) =>
  db.insert(medicationSchedules).values(data).returning();

export const updateMedicationSchedule = (id: string, data: Partial<MedicationSchedule>) =>
  db.update(medicationSchedules).set(data).where(eq(medicationSchedules.id, id)).returning();

export const deleteMedicationSchedule = (id: string) =>
  db.delete(medicationSchedules).where(eq(medicationSchedules.id, id));

export const getAdherenceLogs = (fmmId: string) =>
  db.select().from(medicationAdherenceLogs).where(eq(medicationAdherenceLogs.familyMemberMedicationId, fmmId));

export const createAdherenceLog = (data: MedicationAdherenceLog) =>
  db.insert(medicationAdherenceLogs).values(data).returning();

export const updateAdherenceLog = (id: string, data: Partial<MedicationAdherenceLog>) =>
  db.update(medicationAdherenceLogs).set(data).where(eq(medicationAdherenceLogs.id, id)).returning();