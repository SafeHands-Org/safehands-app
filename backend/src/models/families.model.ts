import { z } from "zod";

const uuid = z.uuid();

const joinCode = z.string().length(6, "Join code must be 6 characters");

export const CreateFamilyBody = z.object({
    name: z.string().min(1, "Family name required")
});

export const updateFamilyBody = z.object({
    name: z.string().min(1, "Family name required").optional()
});

export const addFamilyMemberBody = z.object({
    familyId: uuid,
    userId: z.string().min(1, "User ID required"),
    role: z.enum(["caregiver", "family_member"]).default("family_member"),
});

export const updateFamilyMemberBody = z.object({
    role: z.enum(["caregiver", "family_member"]).optional(),
});

export const createInvitationBody = z.object({
    familyId: uuid,
    joinCode: joinCode,
});

export const checkInvitationParams = z.object({
    familyId: uuid,
    joinCode: joinCode,
});

export type CreateFamilyBody = z.infer<typeof CreateFamilyBody>;
export type updateFamilyBody = z.infer<typeof updateFamilyBody>;
export type addFamilyMemberBody = z.infer<typeof addFamilyMemberBody>;
export type updateFamilyMemberBody = z.infer<typeof updateFamilyMemberBody>;
export type createInvitationBody = z.infer<typeof createInvitationBody>;
export type checkInvitationParams = z.infer<typeof checkInvitationParams>;