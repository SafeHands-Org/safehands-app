import express, { Request, Response, NextFunction } from "express";
import cookieParser from "cookie-parser";
import cors from "cors";

import apiRouter from "./routes";
import { apiRateLimiter } from "./utils/rateLimit";
import { globalErrorHandler } from "./utils/error.handling";
import rxnormRoutes from "./routes/rxnorm.routes";

const app = express();

// app.use((req: Request, _res: Response, next: NextFunction) => {
  // console.log(`${req.method} ${req.path}`);
  // next();
// });

app.use(cors({origin: "*", credentials: true}));
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(apiRateLimiter);
app.use("/api", apiRouter);

app.use(globalErrorHandler);

app.use("/api/rxnorm", rxnormRoutes);

export default app