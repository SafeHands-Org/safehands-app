import { Request, Response, NextFunction } from 'express';
import { z, ZodError } from 'zod';

export const globalErrorHandler = (err: any, req: Request, res: Response, next: NextFunction) => {
  if (err instanceof ZodError) {
    return res.status(400).json({
      status: "fail",
      type: "ValidationError",
      errors: z.treeifyError(err),
    });
  };

  if (err instanceof AppError) {
    return res.status(err.statusCode).json({
      status: "error",
      message: err.message,
    });
  };

  console.log(err);
  res.status(500).json({
    status: "error",
    message: "Internal Server Error",
  });
};

export class AppError extends Error {
  readonly statusCode: number;

  constructor(statusCode: number, message: string) {
    super(message);
    this.statusCode = statusCode;
  }
}

export const badRequest = (msg = "Bad request"): never => {
  throw new AppError(400, msg);
};

export const unauthorized = (msg = "Unauthorized"): never => {
  throw new AppError(401, msg);
};

export const forbidden = (msg = "Forbidden"): never => {
  throw new AppError(403, msg);
};

export const notFound = (msg = "Not found"): never => {
  throw new AppError(404, msg);
};

export const conflict = (msg = "Conflict"): never => {
  throw new AppError(409, msg);
};
