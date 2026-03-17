import app from "./app";
import { initDb } from "./db/index";
import config from './config/config';

const PORT = config.app_port || 8000;

async function start() {
  await initDb();
  app.listen(PORT, '0.0.0.0', () => {
  console.log(`SafeHands started`);
  console.log(`Server: "http://localhost:"${PORT}`);
  console.log(`Listening on port ${PORT} and 0.0.0.0`);
});
}

start();