import { Router } from "express";
import {
  getFamilies,
  createFamily,
  getFamilyById,
  updateFamily,
  deleteFamily,
  addFamilyMember,
  updateFamilyMember,
  removeFamilyMember,
  getFamilyMembers,
  getInvitation
} from "../controllers/families.controller";

const router = Router();

router.route("/")
  .get(getFamilies)
  .post(createFamily);

router.route("/members/:fmId")
  .put(updateFamilyMember)
  .delete(removeFamilyMember);

router.route("/members")
  .get(getFamilyMembers)
  .post(addFamilyMember);

router.route("/invitations")
  .get(getInvitation);

router.route("/:id")
  .get(getFamilyById)
  .put(updateFamily)
  .delete(deleteFamily);

export default router;