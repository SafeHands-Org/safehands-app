import config from './src/config/config';
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  dialect: "postgresql",
  schema: [
    "./dist/db/schema/users.js",
    "./dist/db/schema/families.js",
    "./dist/db/schema/medications.js",
    "./dist/db/schema/sessions.js"
  ],
  out: "./drizzle",
  dbCredentials: {
    url: config.database_url!,
  },
});