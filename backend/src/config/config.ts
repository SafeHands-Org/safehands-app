import dotenv from 'dotenv';

dotenv.config();

interface Config {
  app_port: number;
  db_port: number,
  database_url: string;
  postgres_user: string;
  postgres_password: string;
  postgres_db: string;
  node_env: string;
}

const config: Config = {
  app_port: Number(process.env.APP_PORT) || (() => { throw new Error("APP_PORT not set"); })(),
  db_port: Number(process.env.DB_PORT) || (() => { throw new Error("DB_PORT not set"); })(),
  database_url: process.env.DATABASE_URL || (() => { throw new Error("DATABASE_URL not set"); })(),
  postgres_user: process.env.POSTGRES_USER || (() => { throw new Error("POSTGRES_USER not set"); })(),
  postgres_password: process.env.POSTGRES_PASSWORD || (() => { throw new Error("POSTGRES_PASSWORD not set"); })(),
  postgres_db: process.env.POSTGRES_DB || (() => { throw new Error("POSTGRES_DB not set"); })(),
  node_env: process.env.NODE_ENV || 'development'
}

export default config;