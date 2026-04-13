import { Request, Response } from "express";
import * as rxnormService from "../services/rxnorm.service";
import { getParam } from "../middleware/auth.middleware";

//search RxNorm medications
export const searchMedications = async (req: Request, res: Response) => {
  try {
    const name = req.query.name as string;

    if (!name) {
      return res.status(400).json({ message: "Missing medication name" });
    }

    const results = await rxnormService.searchMedications(name);

    res.json(results);
  } catch (error) {
    console.error("RxNorm search error:", error);
    res.status(500).json({ message: "Failed to search medications" });
  }
};

//get medication details by RXCUI
export const getMedicationDetails = async (req: Request, res: Response) => {
  try {
    const rxcui = getParam(req.params.rxcui, "rxcui");

    const data = await rxnormService.getMedicationDetails(rxcui);

    res.json(data);
  } catch (error) {
    console.error("RxNorm details error:", error);
    res.status(500).json({ message: "Failed to fetch medication details" });
  }
};