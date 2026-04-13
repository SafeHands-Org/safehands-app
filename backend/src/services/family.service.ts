import { db } from "../db";
import { eq, and } from "drizzle-orm";
import { Family, Memberships, Invitation } from "../db/types";
import { families, familyMemberships, invitations } from "../db/schema/families";
import { users } from "../db/schema";

export const getUserMemberships = async (fid: string) => {
  const memberships = await db
    .select({
      member: {
        id: familyMemberships.id,
        name: users.name,
        isAdmin: familyMemberships.isAdmin,
      }
    })
    .from(familyMemberships)
    .innerJoin(users, eq(users.id, familyMemberships.userId))
    .innerJoin(families, eq(families.id, familyMemberships.familyId))
    .where(eq(familyMemberships.familyId, fid))

  return memberships ?? null;
};

export const getAdminMemberships = async (uid: string) => {
  const memberships = await db
  .select({
    member: {
      id: familyMemberships.id,
      fmid: familyMemberships.userId,
      fid: familyMemberships.familyId,
      name: users.name,
      risklevel: familyMemberships.riskLevel,
      isAdmin: familyMemberships.isAdmin,
      createdAt: familyMemberships.createdAt
    }
  })
  .from(families)
  .innerJoin(familyMemberships, eq(familyMemberships.familyId, families.id))
  .innerJoin(users, eq(users.id, familyMemberships.userId))
  .where(eq(families.createdBy, uid))

  return memberships ?? null;
};

export const getUserFamily = async (userId: string) => {
  const [family] = await db
    .select({family: families})
    .from(familyMemberships)
    .innerJoin(families, eq(familyMemberships.familyId, families.id))
    .where(eq(familyMemberships.userId, userId))

  return family;
};

export const getAdminFamilies = async (userId: string) => {
  const family = await db
    .select()
    .from(families)
    .where(eq(families.createdBy, userId));
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
      expiration: new Date(),
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