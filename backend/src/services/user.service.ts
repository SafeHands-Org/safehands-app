import { eq } from "drizzle-orm";

import { db } from "../db";
import { users } from "../db/schema/users";
import { User } from "../db/types";

export const getUserByEmail = async (email: string): Promise<User | null> => {
  const [user] = await db
    .select()
    .from(users)
    .where(eq(users.email, email))
    .limit(1);
  return user ?? null;
};