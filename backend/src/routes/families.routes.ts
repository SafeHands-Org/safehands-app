import { Router } from "express";
import {
  createFamily, 
  getFamilies,
  updateFamily,
  deleteFamily, 
  getFamiliesByUser,
  getFamilyMembers} from "../controllers/families.controller";

const router = Router();

router.post("/", createFamily);

router.get("/", getFamilies);

router.put("/:id", updateFamily);

router.delete("/:id", deleteFamily);

// GET /families/user/:userId
router.get("/user/:userId", getFamiliesByUser);

// GET /families/:familyId/members
router.get("/:familyId/members", getFamilyMembers);

export default router;