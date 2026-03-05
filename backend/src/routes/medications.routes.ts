import { Router } from "express";
import { authMiddleware } from "../middleware/auth.middleware";
import { accessMiddleware } from "../middleware/access.middleware";
import { validateMedication } from "../middleware/medication.validation";

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
  updateAdherenceLog
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

router.route("/member-medications/:id")
  .post(assignMedicationToMember)
  .put(updateFamilyMemberMedication)
  .delete(removeFamilyMemberMedication);

router.route("/member-medications/:id/schedules")
  .get(getMedicationSchedules)
  .post(createMedicationSchedule);

router.route("/member-medications/schedules/:id")
  .put(updateMedicationSchedule)
  .delete(deleteMedicationSchedule);

router.route("/member-medications/:id/logs")
  .get(getAdherenceLogs)
  .post(createAdherenceLog);

router.route("/member-medications/logs/:id")
  .put(updateAdherenceLog);

export default router;