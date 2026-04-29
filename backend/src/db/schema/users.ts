import {
  pgTable,
  uuid,
  text,
  timestamp,
  pgEnum,
  index
} from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";
import { families } from "./families";
import { familyMemberships } from "./families";
import { medicationAdherenceLogs } from "./medications";

export const userRoleEnum = pgEnum("user_role", ["caregiver", "family_member", "viewer", "tester"]);

export const users = pgTable(
  "users",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    name: text("full_name").notNull(),
    email: text("email").notNull().unique(),
    passwordHash: text("password_hash").notNull(),
    role: userRoleEnum("role").notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => [
    index("users_role_idx").on(table.role),
  ]
);

export const usersRelations = relations(users, ({ many }) => ({
  memberships: many(familyMemberships),
  familiesCreated: many(families),
  adherenceRecords: many(medicationAdherenceLogs),
}));
