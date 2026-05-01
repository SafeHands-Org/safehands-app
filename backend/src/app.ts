import express, { Request, Response, NextFunction } from "express";
import cookieParser from "cookie-parser";
import cors from "cors";

import apiRouter from "./routes";
import { apiRateLimiter } from "./utils/rateLimit";
import { globalErrorHandler } from "./utils/error.handling";

const app = express();



app.use(cors({origin: "*", credentials: true}));
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(apiRateLimiter);
app.use("/api", apiRouter);

app.use(globalErrorHandler);

export default app