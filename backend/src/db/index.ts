import { drizzle } from 'drizzle-orm/node-postgres';
import { Pool } from 'pg';
import config from '../config/config';

const pool = new Pool({
  connectionString: config.database_url
});

pool.on('error', () => {
  console.log("Error connecting to the database pool");
});

(async () => {
  await pool.query("SELECT 1");
})();

export const db = drizzle(pool)