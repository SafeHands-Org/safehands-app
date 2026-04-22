import {
  pgTable,
  uuid,
  text,
  timestamp,
  boolean,
  index,
  uniqueIndex,
  pgEnum,
} from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";
import { users } from "./users";

export const riskLevelEnum = pgEnum("risk_level", ["low", "medium", "high"]);

export const families = pgTable(
  "families",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    name: text("name").notNull(),
    createdBy: uuid("created_by")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    index("families_created_by_idx").on(table.createdBy),
  ]
);

export const familyMemberships = pgTable(
  "family_memberships",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    userId: uuid("user_id")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),
    familyId: uuid("family_id")
      .notNull()
      .references(() => families.id, { onDelete: "cascade" }),
    riskLevel: riskLevelEnum("risk_level").notNull(),
    isAdmin: boolean("is_admin").default(false).notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    index("family_memberships_user_idx").on(table.userId),
    index("family_memberships_family_idx").on(table.familyId),
    uniqueIndex("family_memberships_unique_member").on(
      table.userId,
      table.familyId
    ),
  ]
);

export const invitations = pgTable(
  "invitations",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    familyId: uuid("family_id")
      .notNull()
      .references(() => families.id, { onDelete: "cascade" }),

    code: text("code").notNull().unique(),

    used: boolean("used").default(false).notNull(),

    expiration: timestamp("expiration").notNull(),

    createdBy: uuid("created_by")
      .notNull()
      .references(() => users.id, { onDelete: "cascade" }),

    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => [
    index("invitations_family_idx").on(table.familyId),
    index("invitations_code_idx").on(table.code),
  ]
);

export const familiesRelations = relations(families, ({ one, many }) => ({
  creator: one(users, {
    fields: [families.createdBy],
    references: [users.id],
  }),
  members: many(familyMemberships),
  invites: many(invitations),
}));

export const familyMembershipsRelations = relations(familyMemberships, ({ one }) => ({
    user: one(users, {
      fields: [familyMemberships.userId],
      references: [users.id],
    }),
    family: one(families, {
      fields: [familyMemberships.familyId],
      references: [families.id],
    }),
  })
);

export const invitationsRelations = relations(invitations, ({ one }) => ({
  family: one(families, {
    fields: [invitations.familyId],
    references: [families.id],
  }),
  creator: one(users, {
    fields: [invitations.createdBy],
    references: [users.id],
  }),
}));