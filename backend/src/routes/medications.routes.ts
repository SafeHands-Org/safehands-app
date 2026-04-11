import { Router } from "express";
import { authMiddleware } from "../middleware/auth.middleware";
import { validateBody } from "../middleware/validate.body";
import * as v from "../models/medication.model";
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

router.route("/")
  .get(getMedications)
  .post(validateBody(v.NewMedication), createMedication);

router.route("/members")
  .get(getFamilyMemberMedications)
  .post(validateBody(v.NewFamilyMemberMedication), assignMedicationToMember);

router.route("/schedules")
  .get(getMedicationSchedules)
  .post(validateBody(v.NewFamilyMemberMedication), createMedicationSchedule);

router.route("/logs")
  .get(getAdherenceLogs)
  .post(validateBody(v.NewAdherenceLog), createAdherenceLog);

router.route("/members/:fmmId")
  .put(validateBody(v.UpdateFamilyMemberMedication), updateFamilyMemberMedication)
  .delete(removeFamilyMemberMedication);

router.route("/schedules/:schedId")
  .put(validateBody(v.UpdateSchedule), updateMedicationSchedule)
  .delete(deleteMedicationSchedule);

router.route("/logs/:logId")
  .put(validateBody(v.UpdateAdherenceLog), updateAdherenceLog);

router.route("/:id")
  .get(getMedicationById)
  .put(validateBody(v.UpdateMedication), updateMedication)
  .delete(deleteMedication);

export default router;