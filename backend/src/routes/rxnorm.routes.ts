import { Router } from "express";
import * as controller from "../controllers/rxnorm.controller";

const router = Router();

router.get("/search", controller.searchMedications);
router.get("/:rxcui", controller.getMedicationDetails);

export default router;