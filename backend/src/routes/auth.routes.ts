import { Router } from "express";
import { registerUser } from "../controllers/auth/registration.controller";
import { loginUser } from "../controllers/auth/login.controller";

const router = Router();

router.post("/register", registerUser);
router.post("/login", loginUser);

export default router;