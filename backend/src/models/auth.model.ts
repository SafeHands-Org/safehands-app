import { z } from "zod";

export const NewUserBody = z.object({
  name: z.string().min(1, "Name is required"),
  email: z.email("Invalid email"),
  password: z.string().min(8, "Password must be at least 8 characters"),
  role: z.enum(["caregiver", "family_member"]).default("family_member"),
});

export const AuthUserBody = z.object({
  email: z.email("Invalid email"),
  password: z.string().min(8, "Password must be at least 8 characters")
});

export type NewUserBody = z.infer<typeof NewUserBody>;
export type AuthUserBody = z.infer<typeof AuthUserBody>;