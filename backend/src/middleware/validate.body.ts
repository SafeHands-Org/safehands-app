import { Request, Response, NextFunction } from 'express';
import { z } from 'zod';

export const validateBody = (schema: z.ZodTypeAny) => {
  return async (req: Request, _res: Response, next: NextFunction) => {
    schema.safeParse(req.body);
    next();
  };
};