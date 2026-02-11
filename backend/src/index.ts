import express from "express";
import { drizzle } from 'drizzle-orm/node-postgres';
import config from './config/config';
import usersRoutes from "./routes/user-routes";
import familiesRoutes from "./routes/families-routes";
import medicationsRoutes from "./routes/medication-routes";

const app = express();
const db = drizzle(config.database_url!)

app.use(express.json());
app.use("/users", usersRoutes);
app.use("/families", familiesRoutes);
app.use("/medications", medicationsRoutes);

app.get("/", (_req, res) => {
  res.send("SafeHands backend is running");
});

app.listen(config.app_port, () => {
  console.log(`Server running on port ${config.app_port}`);
});

export default app