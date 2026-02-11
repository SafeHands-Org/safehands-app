import { Router } from "express";
import {getAllUsers, getUsersByRole, getUserById,} from "../controllers/user-controller";

const router = Router();

// GET /users
router.get("/", getAllUsers);

// GET /users/role/:role
router.get("/role/:role", getUsersByRole);

// GET /users/:id
router.get("/:id", getUserById);

export default router;