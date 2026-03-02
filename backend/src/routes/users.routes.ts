import { Router } from "express";
import { authMiddleware } from "../middleware/auth.middleware";
import { 
  getUser,
  updateUser,
  deleteUser 
} from "../controllers/users.controller";

const router = Router();

router.use(authMiddleware);

router.route("/:id")
  .get(getUser)
  .patch(updateUser)
  .delete(deleteUser);

export default router;