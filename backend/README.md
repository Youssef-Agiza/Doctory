# Medical Records System

## Local Development

Requirements:

- Node v16

### Initial setup:

1. Create a new branch off `master` with the feature you are working on. From the branch menu on github, type your new branch name and choose create branch off master

2. On your computer inside your project folder, run:

   ```bash
   git clone -b %YOUR_BRANCH_NAME% %REPO_LINK%
   ```

3. Get inside the cloned folder and run:

   ```bash
   npm install
   ```

4. Ask for the .env file and put it beside README.md

5. Change your database user name and password for DATABASE_URL

6. Create a database on your localhost called 'HealthRecordsDB' and run:

   ```bash
   npx prisma migrate dev --name init
   ```

### Starting the App

1. Now you can call your requests to 'http://localhost:8000/api'. To start the server, run:

   ```bash
   npm run dev
   ```

# Known Issues

- delete user may result in delete all the records if the request body params is not proper.
