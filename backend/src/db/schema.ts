import * as psql from "drizzle-orm/pg-core"

export const userRoleEnum = ["caregiver", "family_member", "clinician"] as const;
export const familyRoleEnum = ["admin", "viewer", "taker"] as const;
export const adherenceStatusEnum = ["taken", "missed", "skipped"] as const;
export const frequencyEnum = ["daily", "weekly", "as_needed"] as const;

export const users = psql.pgTable("users", {
  id: psql.uuid("id").defaultRandom().primaryKey(),
  fullName: psql.text("full_name").notNull(),
  email: psql.text("email").notNull().unique(),
  passwordHash: psql.text("password_hash").notNull(),
  role: psql.text("role", { enum: userRoleEnum }).notNull(),
  createdAt: psql.timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
  updatedAt: psql.timestamp("updated_at", { withTimezone: true }).defaultNow().notNull(),
});

export const families = psql.pgTable("families", {
  id: psql.uuid("id").defaultRandom().primaryKey(),
  name: psql.text("name").notNull(),
  createdBy: psql.uuid("created_by")
    .notNull()
    .references(() => users.id, { onDelete: "cascade" }),
  createdAt: psql.timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
});

export const familyMemberships = psql.pgTable(
  "family_memberships",
  {
    id: psql.serial("id").primaryKey(),
    userId: psql.uuid("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    familyId: psql.uuid("family_id")
      .notNull()
      .references(() => families.id, { onDelete: "cascade" }),
    role: psql.text("role", { enum: familyRoleEnum }).notNull(),
    createdAt: psql.timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
  },
);

export const medications = psql.pgTable("medications", {
  id: psql.uuid("id").defaultRandom().primaryKey(),
  name: psql.text("name").notNull(),
  dosage: psql.text("dosage").notNull(),
  instructions: psql.text("instructions"),
  createdBy: psql.uuid("created_by")
    .notNull()
    .references(() => users.id, { onDelete: "set null" }),
  createdAt: psql.timestamp("created_at", { withTimezone: true }).defaultNow().notNull(),
});

export const familyMemberMedications = psql.pgTable("family_member_medications", {
  id: psql.serial("id").primaryKey(),
  medicationId: psql.uuid("medication_id")
    .notNull()
    .references(() => medications.id, { onDelete: "cascade" }),
  familyMemberId: psql.uuid("family_member_id")
    .notNull()
    .references(() => users.id, { onDelete: "cascade" }),
  startDate: psql.date("start_date").notNull(),
  endDate: psql.date("end_date"),
  active: psql.boolean("active").default(true).notNull(),
});
