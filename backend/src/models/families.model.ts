import { z } from "zod";

export const CreateFamilyBody = z.object({
    name: z.string().min(1, "Family name required")
});

export const updateFamilyBody = z.object({
    name: z.string().min(1, "Family name required").optional()
});

export const addFamilyMemberBody = z.object({
    userId: z.string().min(1, "User ID requiered"),
    role: z.enum(["caregiver", "family_member"]).default("family_member"),
});

export type CreateFamilyBody = z.infer<typeof CreateFamilyBody>;
export type updateFamilyBody = z.infer<typeof updateFamilyBody>;
export type addFamilyMemberBody = z.infer<typeof addFamilyMemberBody>;