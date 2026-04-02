import express from "express";
import authRoutes from "./auth.routes";
import userRoutes from "./users.routes";
import familiesRoutes from "./families.routes";
import medicationsRoutes from "./medications.routes";
import { authMiddleware } from "../middleware/auth.middleware";
import dashboardRoutes from "./dashboard.routes"

const apiRouter = express.Router();

apiRouter.use("/auth", authRoutes);
apiRouter.use("/users", authMiddleware, userRoutes);
apiRouter.use("/families", authMiddleware, familiesRoutes);
apiRouter.use("/medications", authMiddleware, medicationsRoutes);
apiRouter.use("/dashboard", authMiddleware, dashboardRoutes);

export default apiRouter;