import { Router } from "express";
import {createMedication, assignMedication, addMedicationSchedule, getMedicationsForFamilyMember} from "../controllers/medication-controller";

const router = Router();

// POST /medications
router.post("/", createMedication);

// POST /medications/assign
router.post("/assign", assignMedication);

// POST /medications/schedule
router.post("/schedule", addMedicationSchedule);

// GET /medications/family-member/:familyMemberId
router.get("/family-member/:familyMemberId", getMedicationsForFamilyMember);

export default router;