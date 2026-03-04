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

export default router;