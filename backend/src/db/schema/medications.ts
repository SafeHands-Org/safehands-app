import {
  pgTable,
  uuid,
  text,
  timestamp,
  date,
  time,
  integer,
  boolean,
  index,
  pgEnum,
} from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";
import { users } from "./users";
import { familyMemberships } from "./families";

export const doseFormEnum = pgEnum("dose_form", [
  "tablet",
  "capsule",
  "liquid",
  "inhaler",
  "injection",
  "topical",
  "drops",
  "patch",
  "suppository",
  "other",
]);

export const weekdayEnum = pgEnum("weekdays", [
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday",
  "sunday",
])

export const frequencyUnitsEnum = pgEnum("frequency_units", [
  "days",
  "weeks",
])

export const priorityEnum = pgEnum("priority", ["low", "medium", "high"]);

export const medications = pgTable(
  "medications",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    nameEntered: text("name_entered").notNull(),
    rxcui: text("rxcui"),
    dosage: text("dosage"),
    doseForm: doseFormEnum("dose_form").notNull(),
    instructions: text("instructions"),
    createdBy: uuid("created_by")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    index("medications_creator_idx").on(table.createdBy),
  ]
);

export const familyMemberMedications = pgTable(
  "family_member_medications",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    medicationId: uuid("medication_id")
      .notNull()
      .references(() => medications.id, { onDelete: "cascade" }),
    familyMemberId: uuid("family_member_id")
      .notNull()
      .references(() => familyMemberships.id, { onDelete: "cascade" }),
    priority: priorityEnum("priority").notNull(),
    startDate: date("start_date").notNull(),
    endDate: date("end_date"),
    active: boolean("active").default(true).notNull(),
  },
  (table) => [
    index("fmm_medication_idx").on(table.medicationId),
    index("fmm_member_idx").on(table.familyMemberId),
  ]
);

export const medicationSchedules = pgTable(
  "medication_schedules",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    familyMemberMedicationId: uuid("family_member_medication_id")
      .notNull()
      .references(() => familyMemberMedications.id, { onDelete: "cascade" }),
    timesOfDay: time("times_of_day").array().notNull(),
    daysOfWeek: weekdayEnum("days_of_week").array(),
    frequency: integer("frequency").notNull(),
    frequencyUnit: frequencyUnitsEnum("frequency_unit").notNull(),
  },
  (table) => [
    index("schedule_fmm_idx").on(table.familyMemberMedicationId),
  ]
);

export const medicationAdherenceLogs = pgTable(
  "medication_adherence_logs",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    familyMemberMedicationId: uuid("family_member_medication_id")
      .notNull()
      .references(() => familyMemberMedications.id, { onDelete: "cascade" }),
    scheduledTime: time("scheduled_time").notNull(),
    takenAt: timestamp("taken_at"),
    status: text("status").notNull(),
    recordedBy: uuid("recorded_by")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
  },
  (table) => [
    index("log_fmm_idx").on(table.familyMemberMedicationId),
    index("log_recorded_by_idx").on(table.recordedBy),
  ]
);

export const medicationsRelations = relations(medications, ({ one, many }) => ({
  creator: one(users, {
    fields: [medications.createdBy],
    references: [users.id],
  }),
  assignments: many(familyMemberMedications),
}));

export const familyMemberMedicationsRelations = relations(familyMemberMedications, ({ one, many }) => ({
    medication: one(medications, {
      fields: [familyMemberMedications.medicationId],
      references: [medications.id],
    }),
    member: one(familyMemberships, {
      fields: [familyMemberMedications.familyMemberId],
      references: [familyMemberships.id],
    }),
    schedules: many(medicationSchedules),
    logs: many(medicationAdherenceLogs),
  })
);

export const medicationSchedulesRelations = relations(medicationSchedules, ({ one }) => ({
    familyMemberMedication: one(familyMemberMedications, {
      fields: [medicationSchedules.familyMemberMedicationId],
      references: [familyMemberMedications.id],
    }),
  })
);

export const medicationAdherenceLogsRelations = relations(medicationAdherenceLogs, ({ one }) => ({
    familyMemberMedication: one(familyMemberMedications, {
      fields: [medicationAdherenceLogs.familyMemberMedicationId],
      references: [familyMemberMedications.id],
    }),
    recorder: one(users, {
      fields: [medicationAdherenceLogs.recordedBy],
      references: [users.id],
    }),
  })
);