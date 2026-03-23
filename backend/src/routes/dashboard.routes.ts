import { Router } from "express";
import { getCaregiverDashboard, getFamilyMemberDashboard } from "../controllers/dashboard.controller";
import { authMiddleware } from "../middleware/auth.middleware";

const router = Router();

router.get("/caregiver", authMiddleware, getCaregiverDashboard);
router.get("/family-member", authMiddleware, getFamilyMemberDashboard);

export default router;