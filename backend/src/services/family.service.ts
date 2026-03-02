import { db } from "../db";
import { eq, and } from "drizzle-orm";
import { Memberships } from "../db/types"
import { 
  families, 
  familyMemberships, 
  users, 
  invitations 
} from "../db/schema";

export const getFamilyMembership = async (userId: string, familyId: string): Promise<Memberships | null> => {
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