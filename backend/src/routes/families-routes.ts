import { Router } from "express";
import {createFamily, getAllFamilies, getFamiliesByUser,getFamilyMembers} from "../controllers/families-controller";

const router = Router();

// POST /families
router.post("/", createFamily);

// GET /families
router.get("/", getAllFamilies);

// GET /families/user/:userId
router.get("/user/:userId", getFamiliesByUser);

// GET /families/:familyId/members
router.get("/:familyId/members", getFamilyMembers);

export default router;