CREATE TYPE "public"."dose_form" AS ENUM('tablet', 'capsule', 'liquid', 'inhaler', 'injection', 'topical', 'drops', 'patch', 'suppository', 'other');--> statement-breakpoint
CREATE TABLE "sessions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"session_token" text NOT NULL,
	"expires_at" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "sessions_session_token_unique" UNIQUE("session_token")
);
--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "role" SET DATA TYPE text;--> statement-breakpoint
DROP TYPE "public"."user_role";--> statement-breakpoint
CREATE TYPE "public"."user_role" AS ENUM('caregiver', 'family_member', 'viewer');--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "role" SET DATA TYPE "public"."user_role" USING "role"::"public"."user_role";--> statement-breakpoint
DROP INDEX "users_email_idx";--> statement-breakpoint
ALTER TABLE "family_memberships" ADD COLUMN "is_admin" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "medications" ADD COLUMN "name_entered" text NOT NULL;--> statement-breakpoint
ALTER TABLE "medications" ADD COLUMN "rxcui" text;--> statement-breakpoint
ALTER TABLE "medications" ADD COLUMN "dose_form" "dose_form" NOT NULL;--> statement-breakpoint
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "family_memberships" DROP COLUMN "role";--> statement-breakpoint
ALTER TABLE "medications" DROP COLUMN "name";