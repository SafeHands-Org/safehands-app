# Prerequisites
Make sure you have the following installed:

- Docker + Docker Compose
- Node.js + npm
- Flutter SDK
- Android Studio and/or Xcode (for emulators/simulators)

---

# Docker
Open a terminal and navigate to the backend directory:
`cd backend` 
All backend commands must be run inside the backend directory (not the project root).

Create a new file called .env and paste the following into it:

```
APP_PORT=8000

DB_PORT=5432
DATABASE_URL=postgresql://safehands_admin:<YOUR_PASSWORD>@db:5432/safehands_db
POSTGRES_USER=safehands_admin
POSTGRES_PASSWORD=<YOUR_PASSWORD>
POSTGRES_DB=safehands_db

JWT_SECRET=<YOUR_JWT_SECRET>

NODE_ENV=development
```

`npm install` To install dependencies to generate that node_modules folder. 
`npm run build` To build the typescript project and generate the dist folder.
`docker compose up --build` This will build the image again using. You’ll know the backend is now running if it says “Server running on port 8000”

These steps must be succesfully completed before you can run the frontend. If Docker fails to start or the database becomes corrupted, reset everything using `docker compose down -v`. Once Docker is up and running, do NOT close Docker. If you do, the front end will fail to build. Once Docker has been successfully set up you only need to run `docker compose up` going forward.

---

# Flutter
While Docker is running, in a new terminal run:
`cd frontend` This will switch you to the frontend directory where the Flutter files live.

`flutter run -d <device_id>` This builds the app and allows you to choose which device to run it on (IOS Simulator/Android Emulator).

***This app has not been deployed on app stores and is only available through GitHub.***
