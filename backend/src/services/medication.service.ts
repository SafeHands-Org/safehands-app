import { db } from "../db";
import { medications, familyMemberMedications, medicationSchedules, medicationAdherenceLogs, users, familyMemberships, families} from "../db/schema";
import { eq } from "drizzle-orm";
import { Medication, FamilyMemberMedication, MedicationSchedule, MedicationAdherenceLog } from "../db/types";

export const getAllMedications = async (userId: string) => {
  const meds = await db
    .select({ medication : medications })
    .from(medications)
    .innerJoin(users, eq(users.id, medications.createdBy))
    .where(eq(medications.createdBy, userId));
  return meds
}

export const createMedication = async (data: Medication) =>
  await db.insert(medications).values(data).returning();

export const getMedicationById = async (id: string) =>
  await db.select().from(medications).where(eq(medications.id, id));

export const updateMedication = async (id: string, data: Partial<Medication>) =>
  await db.update(medications).set(data).where(eq(medications.id, id)).returning();

export const deleteMedication = async (id: string) =>
  await db.delete(medications).where(eq(medications.id, id));

export const getFamilyMemberMedications = async (memberId: string) =>
  await db.select({assignment: familyMemberMedications}).from(familyMemberMedications).where(eq(familyMemberMedications.familyMemberId, memberId));

export const getCaregiverFamilyMedications = async (userId: string) => {
  const medications = await db
    .select({assignment: familyMemberMedications})
    .from(familyMemberMedications)
    .innerJoin(familyMemberships, eq(familyMemberMedications.familyMemberId, familyMemberships.id))
    .innerJoin(families, eq(familyMemberships.familyId, families.id))
    .where(eq(families.createdBy, userId));
  return medications
}

export const assignMedicationToMember = async (data: FamilyMemberMedication) =>
  await db.insert(familyMemberMedications).values(data).returning();

export const updateFamilyMemberMedication = async (id: string, data: Partial<FamilyMemberMedication>) =>
  await db.update(familyMemberMedications).set(data).where(eq(familyMemberMedications.id, id)).returning();

export const removeFamilyMemberMedication = async (id: string) =>
  await db.delete(familyMemberMedications).where(eq(familyMemberMedications.id, id));

export const getMemberMedicationSchedules = async (userId: string) => {
  const schedules = await db
    .select({
      schedules: {
        id: medicationSchedules.id,
        fmmid: medicationSchedules.familyMemberMedicationId,
        fmid: familyMemberships.id,
        timesOfDay: medicationSchedules.timesOfDay,
        daysOfWeek: medicationSchedules.daysOfWeek,
        frequency: medicationSchedules.frequency,
      }})
    .from(medicationSchedules)
    .innerJoin(familyMemberMedications, eq(medicationSchedules.familyMemberMedicationId, familyMemberMedications.id))
    .innerJoin(familyMemberships, eq(familyMemberMedications.familyMemberId, familyMemberships.id))
    .where(eq(familyMemberships.userId, userId));
  return schedules
}
export const getCaregiverMedicationSchedules = async (userId: string) => {
  const medications = await db
    .select({
      schedules: {
        id: medicationSchedules.id,
        fmmid: medicationSchedules.familyMemberMedicationId,
        fmid: familyMemberships.id,
        timesOfDay: medicationSchedules.timesOfDay,
        daysOfWeek: medicationSchedules.daysOfWeek,
        frequency: medicationSchedules.frequency,
      }})
    .from(medicationSchedules)
    .innerJoin(familyMemberMedications, eq(medicationSchedules.familyMemberMedicationId, familyMemberMedications.id))
    .innerJoin(familyMemberships, eq(familyMemberMedications.familyMemberId, familyMemberships.id))
    .innerJoin(families, eq(familyMemberships.familyId, families.id))
    .where(eq(families.createdBy, userId));
  return medications
}

export const createMedicationSchedule = async (data: MedicationSchedule) => {
  const [inserted] = await db.insert(medicationSchedules).values(data).returning();
  const [result] = await db
    .select({
      id: medicationSchedules.id,
      fmmid: medicationSchedules.familyMemberMedicationId,
      fmid: familyMemberships.id,
      timesOfDay: medicationSchedules.timesOfDay,
      daysOfWeek: medicationSchedules.daysOfWeek,
      frequency: medicationSchedules.frequency,
    })
    .from(medicationSchedules)
    .innerJoin(familyMemberMedications, eq(medicationSchedules.familyMemberMedicationId, familyMemberMedications.id))
    .innerJoin(familyMemberships, eq(familyMemberMedications.familyMemberId, familyMemberships.id))
    .where(eq(medicationSchedules.id, inserted.id));
  return result;
};

export const updateMedicationSchedule = async (id: string, data: Partial<MedicationSchedule>) =>
  await db.update(medicationSchedules).set(data).where(eq(medicationSchedules.id, id)).returning();

export const deleteMedicationSchedule = async (id: string) =>
  await db.delete(medicationSchedules).where(eq(medicationSchedules.id, id));

export const getMemberAdherenceLogs = async (userId: string) => {
  const adherences = await db
    .select({
      logs: {
        id: medicationAdherenceLogs.id,
        fmid: familyMemberships.id,
        fmmid: medicationAdherenceLogs.familyMemberMedicationId,
        scheduledTime: medicationAdherenceLogs.scheduledTime,
        takenAt: medicationAdherenceLogs.takenAt,
        status: medicationAdherenceLogs.status,
        recordedBy: medicationAdherenceLogs.recordedBy,
      }
    })
    .from(medicationAdherenceLogs)
    .innerJoin(familyMemberMedications, eq(medicationAdherenceLogs.familyMemberMedicationId, familyMemberMedications.id))
    .innerJoin(familyMemberships, eq(familyMemberMedications.familyMemberId, familyMemberships.id))
    .where(eq(familyMemberships.userId, userId));
  return adherences
}

export const getCaregiverAdherenceLogs = async (userId: string) => {
  const adherences = await db
    .select({
      logs: {
        id: medicationAdherenceLogs.id,
        fmid: familyMemberships.id,
        fmmid: medicationAdherenceLogs.familyMemberMedicationId,
        scheduledTime: medicationAdherenceLogs.scheduledTime,
        takenAt: medicationAdherenceLogs.takenAt,
        status: medicationAdherenceLogs.status,
        recordedBy: medicationAdherenceLogs.recordedBy,
      }
    })
    .from(medicationAdherenceLogs)
    .innerJoin(familyMemberMedications, eq(medicationAdherenceLogs.familyMemberMedicationId, familyMemberMedications.id))
    .innerJoin(familyMemberships, eq(familyMemberMedications.familyMemberId, familyMemberships.id))
    .innerJoin(families, eq(familyMemberships.familyId, families.id))
    .where(eq(families.createdBy, userId));
  return adherences
}

export const createAdherenceLog = async (data: MedicationAdherenceLog) =>
  await db.insert(medicationAdherenceLogs).values(data).returning();

export const updateAdherenceLog = async (id: string, data: Partial<MedicationAdherenceLog>) =>
  await db.update(medicationAdherenceLogs).set(data).where(eq(medicationAdherenceLogs.id, id)).returning();