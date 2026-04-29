import { drizzle, NodePgDatabase } from "drizzle-orm/node-postgres";
import { migrate } from "drizzle-orm/node-postgres/migrator";
import { Pool } from "pg";
import config from "../config/config";
import * as schema from "./schema";

export const pool = new Pool({ connectionString: config.database_url });
export const db = drizzle(pool, { schema });

export async function initDb() {
  try {
    await pool.query("SELECT 1");
    await migrate(db, {
      migrationsFolder: "./drizzle",
      migrationsTable: "__drizzle_migrations",
      migrationsSchema: "public",
    });

    console.log("Database connected and migrations applied");
  } catch (err) {
    console.error("Database startup failed:", err);
    process.exit(1);
  }
}