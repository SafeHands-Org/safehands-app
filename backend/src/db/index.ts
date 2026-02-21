import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import config from "../config/config";
import * as schema from "./schema";

export const pool = new Pool({
  connectionString: config.database_url,
});

pool.on("error", (err) => {
  console.error("Unexpected PG pool error", err);
  process.exit(1);
});

export const db = drizzle(pool, { schema });

export async function connectDB() {
  try {
    await pool.query("SELECT 1");
    console.log("Database connected");
  } catch (err) {
    console.error("Database connection failed");
    process.exit(1);
  }
}