import express from "express";
import authRoutes from "./auth.routes";
import userRoutes from "./users.routes";
import familiesRoutes from "./families.routes"; 
import medicationsRoutes from "./medications.routes";

const apiRouter = express.Router();

apiRouter.use("/auth", authRoutes);
apiRouter.use("/users", userRoutes);
apiRouter.use("/families", familiesRoutes);
apiRouter.use("/medications", medicationsRoutes);

export default apiRouter;