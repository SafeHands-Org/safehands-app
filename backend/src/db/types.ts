import { type InferSelectModel, type InferEnum } from "drizzle-orm";
import { users, userRoleEnum } from "../db/schema/users";
import { familyMemberships } from "../db/schema/families";
import { sessionsTable } from "../db/schema/sessions";

export type User = InferSelectModel<typeof users>;
export type UserRole = InferEnum<typeof userRoleEnum>;
export type Session = Pick<InferSelectModel<typeof sessionsTable>, "userId" | "sessionToken" | "expiresAt">;
export type TokenPayload = Pick<InferSelectModel<typeof users>, "id" | "role" >;
export type Memberships = InferSelectModel<typeof familyMemberships>;