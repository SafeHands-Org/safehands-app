import { db } from "../db";
import { eq, and } from "drizzle-orm";
import { Family, Memberships, Invitation } from "../db/types";
import { families, familyMemberships, invitations } from "../db/schema/families";

export const getFamilyMembership = async (
  userId: string,
  familyId: string
): Promise<Memberships | null> => {
  const [membership] = await db
    .select()
    .from(familyMemberships)
    .where(
      and(
        eq(familyMemberships.userId, userId),
        eq(familyMemberships.familyId, familyId)
      )
    )
    .limit(1);

  return membership ?? null;
};

export const getUserFamilies = async (userId: string) => {
  const [family] = await db
    .select({
      membership: familyMemberships,
      family: families,
    })
    .from(familyMemberships)
    .innerJoin(families, eq(familyMemberships.familyId, families.id))
    .where(eq(familyMemberships.userId, userId));
  return family;
};

export const createFamily = async (data: Family) => {
  const [family] = await db
    .insert(families)
    .values({
      name: data.name,
      createdBy: data.createdBy,
    })
    .returning();

  return family;
};

export const getFamilyById = async (id: string) => {
  const [family] = await db
    .select()
    .from(families)
    .where(eq(families.id, id))
    .limit(1);

  return family ?? null;
};

export const updateFamily = async (id: string, data: Partial<Family>) => {
  const [updated] = await db
    .update(families)
    .set(data)
    .where(eq(families.id, id))
    .returning();

  return updated;
};

export const deleteFamily = async (id: string) => {
  await db.delete(families).where(eq(families.id, id));
};

export const addFamilyMember = async (data: Memberships) => {
  const [membership] = await db
    .insert(familyMemberships)
    .values({
      ...data
    })
    .returning();

  return membership;
};

export const updateFamilyMember = async (
  id: string,
  data: Partial<Memberships>
) => {
  const [updated] = await db
    .update(familyMemberships)
    .set(data)
    .where(eq(familyMemberships.id, id))
    .returning();

  return updated;
};

export const removeFamilyMember = async (id: string) => {
  await db.delete(familyMemberships).where(eq(familyMemberships.id, id));
};

export const createInvitation = async (data: Invitation) => {
  const [invitation] = await db
    .insert(invitations)
    .values({
      familyId: data.familyId,
      token: data.token,
      expiration: new Date(), // convert string to Date
      createdBy: data.createdBy,
    })
    .returning();

  return invitation;
};

export const checkInvitation = async (token: string) => {
  const [invitation] = await db
    .select()
    .from(invitations)
    .where(eq(invitations.token, token))
    .limit(1);

  return invitation ?? null;
};