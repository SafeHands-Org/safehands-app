import express, { Request, Response, NextFunction } from "express";
import cookieParser from "cookie-parser";
import cors from "cors";
import config from './config/config';
import authRouter from "./routes/auth.routes";
import usersRouter from "./routes/users.routes";
import familiesRouter from "./routes/families.routes";
import medicationsRouter from "./routes/medications.routes";

const PORT = config.app_port || 8000;
const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use((req: Request, _res: Response, next: NextFunction) => {
  console.log(`${req.method} ${req.path}`);
  next();
});

app.use("/api/auth", authRouter);
app.use("/api/users", usersRouter);
app.use("/api/families", familiesRouter);
app.use("/api/medications", medicationsRouter);

app.get("/health", (req, res) => {
  res.status(200).json({ status: "OK" });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});