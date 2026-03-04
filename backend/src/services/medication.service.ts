import { db } from "../db";
import {
  medications,
  familyMemberMedications,
  medicationSchedules,
  medicationAdherenceLogs,
} from "../db/schema";
import { InferInsertModel, eq } from "drizzle-orm";

type MedicationInsert = InferInsertModel<typeof medications>;
type MedicationUpdate = Partial<
  Omit<MedicationInsert, "id" | "createdAt" | "createdBy">
>;

export const getAllMedications = async (userId: string) => {
  return db.select()
    .from(medications)
    .where(eq(medications.createdBy, userId));
};

export const createMedication = async (
  data: MedicationInsert
) => {
  const result = await db.insert(medications)
    .values(data)
    .returning();

  return result[0];
};

export const getMedicationById = async (id: string) => {
  const result = await db.select()
    .from(medications)
    .where(eq(medications.id, id));

  return result[0];
};

export const updateMedication = async (
  id: string,
  data: MedicationUpdate
) => {
  const result = await db.update(medications)
    .set(data)
    .where(eq(medications.id, id))
    .returning();

  return result[0];
};

export const deleteMedication = async (id: string) => {
  await db.delete(medications)
    .where(eq(medications.id, id));
};

export const getFamilyMemberMedications = async (memberId: string) => {
  return db.select()
    .from(familyMemberMedications)
    .where(eq(familyMemberMedications.familyMemberId, memberId));
};

export const assignMedicationToMember = async (data: any) => {
  const result = await db.insert(familyMemberMedications)
    .values(data)
    .returning();

  return result[0];
};

export const updateFamilyMemberMedication = async (id: string, data: any) => {
  const result = await db.update(familyMemberMedications)
    .set(data)
    .where(eq(familyMemberMedications.id, id))
    .returning();

  return result[0];
};

export const removeFamilyMemberMedication = async (id: string) => {
  await db.delete(familyMemberMedications)
    .where(eq(familyMemberMedications.id, id));
};

export const getMedicationSchedules = async (fmmId: string) => {
  return db.select()
    .from(medicationSchedules)
    .where(eq(medicationSchedules.familyMemberMedicationId, fmmId));
};

export const createMedicationSchedule = async (data: any) => {
  const result = await db.insert(medicationSchedules)
    .values(data)
    .returning();

  return result[0];
};

export const updateMedicationSchedule = async (id: string, data: any) => {
  const result = await db.update(medicationSchedules)
    .set(data)
    .where(eq(medicationSchedules.id, id))
    .returning();

  return result[0];
};

export const deleteMedicationSchedule = async (id: string) => {
  await db.delete(medicationSchedules)
    .where(eq(medicationSchedules.id, id));
};

export const getAdherenceLogs = async (fmmId: string) => {
  return db.select()
    .from(medicationAdherenceLogs)
    .where(eq(medicationAdherenceLogs.familyMemberMedicationId, fmmId));
};

export const createAdherenceLog = async (data: any) => {
  const result = await db.insert(medicationAdherenceLogs)
    .values(data)
    .returning();

  return result[0];
};

export const updateAdherenceLog = async (id: string, data: any) => {
  const result = await db.update(medicationAdherenceLogs)
    .set(data)
    .where(eq(medicationAdherenceLogs.id, id))
    .returning();

  return result[0];
};