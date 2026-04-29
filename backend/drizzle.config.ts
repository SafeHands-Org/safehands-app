import config from './src/config/config';
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  dialect: "postgresql",
  schema: [
    "./src/db/schema/users.ts",
    "./src/db/schema/families.ts",
    "./src/db/schema/medications.ts",
    "./src/db/schema/sessions.ts"
  ],
  out: "./drizzle",
  dbCredentials: {
    url: config.database_url!,
  },
});