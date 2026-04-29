import { Router } from "express";
import { registerUser, loginUser, me } from "../controllers/auth.controller";
import { authMiddleware } from "../middleware/auth.middleware";
import { validateBody } from "../middleware/validate.body";
import { NewUserBody, AuthUserBody } from "../models/auth.model";

const router = Router();

router.post("/register", validateBody(NewUserBody), registerUser);
router.post("/login", validateBody(AuthUserBody), loginUser);

router.get("/me", authMiddleware, me);

export default router;