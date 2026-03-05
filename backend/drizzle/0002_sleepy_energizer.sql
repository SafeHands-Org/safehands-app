CREATE TYPE "public"."risk_level" AS ENUM('low', 'medium', 'high');--> statement-breakpoint
CREATE TYPE "public"."priority" AS ENUM('low', 'medium', 'high');--> statement-breakpoint
ALTER TABLE "family_memberships" ADD COLUMN "risk_level" "risk_level" NOT NULL;--> statement-breakpoint
ALTER TABLE "family_member_medications" ADD COLUMN "priority" "priority" NOT NULL;