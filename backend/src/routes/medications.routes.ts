import { Router } from "express";
import { authMiddleware } from "../middleware/auth.middleware";
import { accessMiddleware } from "../middleware/access.middleware";
import {
  validateMedication,
  validateFamilyMemberMedication,
  validateSchedule,
  validateAdherenceLog,
} from "../middleware/medication.validation";

import {
  getMedications,
  createMedication,
  getMedicationById,
  updateMedication,
  deleteMedication,
  getFamilyMemberMedications,
  assignMedicationToMember,
  updateFamilyMemberMedication,
  removeFamilyMemberMedication,
  getMedicationSchedules,
  createMedicationSchedule,
  updateMedicationSchedule,
  deleteMedicationSchedule,
  getAdherenceLogs,
  createAdherenceLog,
  updateAdherenceLog,
} from "../controllers/medications.controller";

const router = Router();

router.use(authMiddleware);
router.use(accessMiddleware);

router.route("/")
  .get(getMedications)
  .post(validateMedication, createMedication);

router.route("/:id")
  .get(getMedicationById)
  .put(validateMedication, updateMedication)
  .delete(deleteMedication);

router.route("/members/:memberId/medications")
  .get(getFamilyMemberMedications);

router.route("/member-medications")
  .post(validateFamilyMemberMedication, assignMedicationToMember);

router.route("/member-medications/:id")
  .put(validateFamilyMemberMedication, updateFamilyMemberMedication)
  .delete(removeFamilyMemberMedication);

router.route("/member-medications/:id/schedules")
  .get(getMedicationSchedules)
  .post(validateSchedule, createMedicationSchedule);

router.route("/member-medications/schedules/:id")
  .put(validateSchedule, updateMedicationSchedule)
  .delete(deleteMedicationSchedule);

router.route("/member-medications/:id/logs")
  .get(getAdherenceLogs)
  .post(validateAdherenceLog, createAdherenceLog);

router.route("/member-medications/logs/:id")
  .put(validateAdherenceLog, updateAdherenceLog);

export default router;