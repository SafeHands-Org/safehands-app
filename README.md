# SafeHands - Caring for every hand in your family.
SafeHands is a platform for adults managing medications for their families who need a reliable way to ensure medications are taken safely and correctly. We are a family medication management app that centralizes
schedules, instructions, and adherence tracking for every
family member.  Unlike single-user reminder apps, paper
logs, or pharmacy printouts, our product provides shared
visibility, proactive alerts, and an opt-in emergency mode
that gives clinicians immediate, read-only access to
critical medication information to avoid adverse side
effects and complications.​

# How to Run
In order to run this application through an emulator or simulator, Docker must be set up first. Open Docker and have it running in the background while you run the following commands on your terminal:

`cd backend` This is to switch to the backend directory where all these commands need to occur. Not the safehands-app directory.

`npm install` To install dependencies to generate that node_modules folder. It’ll install the packages in package.json

`npm run build` To build the typescript project and generate the dist folder.

`docker compose run --rm backend npm run migrate` This will apply the migration that is in the drizzle folder already to the database in the docker container

`docker compose up —build` This will build the image again using. You’ll know the backend is now running if it says “Server running on port 8000”

These steps must be succesfully completed before you can run the emulator. If the Docker isn't working use `docker compose down -v` to start over with a clean slate. Once Docker is up and running, run the following commands in a new terminal. Do NOT close Docker. If you do, the build will fail.

`cd frontend` This will switch you to the frontend directory where the Flutter files live.

`flutter run -d <device_id>` This builds the app and allows you to choose which device to run it on.