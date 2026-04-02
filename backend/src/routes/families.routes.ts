import { Router } from "express";
import {
  getUserFamilies,
  createFamily,
  getFamilyById,
  updateFamily,
  deleteFamily,
  addFamilyMember,
  updateFamilyMember,
  removeFamilyMember,
  createInvitation,
  checkInvitation,
} from "../controllers/families.controller";

const router = Router();

router.route("/")
  .get(getUserFamilies)
  .post(createFamily);

router.route("/:id")
  .get(getFamilyById)
  .put(updateFamily)
  .delete(deleteFamily);

router.route("/:id/members")
  .post(addFamilyMember)

router.route("/:id/members/:memberId")
  .put(updateFamilyMember)
  .delete(removeFamilyMember);

router.route("/:id/invitations")
  .post(createInvitation);

router.route("/invitations/:token")
  .get(checkInvitation)

export default router;