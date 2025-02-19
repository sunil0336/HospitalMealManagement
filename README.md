# HospitalMealManagement

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- [Node.js](https://nodejs.org/) (version 14 or above recommended)
- [npm](https://www.npmjs.com/) (Node package manager)


## Tech Stack

### Frontend
- **HTML**
- **CSS**
- **JavaScript (JS)**

### Backend
- **Express.js**

### Database
- **PostgreSQL (PSQL)**

## Setup

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/sunil0336/HospitalMealManagement.git
```

### 2. Install Dependencies

Navigate to the project directory and install the necessary dependencies using npm:

```bash
cd HospitalMealManagement/Backend
npm install
npm install cors
```

### 3. Start the Backend Server

Once all dependencies are installed, you can start the Backend server by running the following command:

```bash
node server.js
or
npm start
```

By default, the server will start on [http://localhost:3000](http://localhost:3000).

```
PORT=3000
DB_URI=mongodb://your-db-uri
```

## Start the Frontend with Live Server

- Open the frontend files (HTML) in your vscode
  
- Install the **Live Server** extension in VS Code if you haven't already.
  
- Right-click on your `index.html` file (or any entry HTML file) and select **"Open with Live Server"**.
  
  This will start a local server for your frontend at [http://127.0.0.1:5500](http://127.0.0.1:5500) (or another port depending on your configuration).

- You can now view the frontend in your browser and make changes to the HTML, CSS, and JS files. The browser will auto-refresh to show any updates you make.


---

Make sure you should create all database tables in your machine 

---
## Database Connection Setup

This project uses **PostgreSQL** for the database. Below are the steps to set up the database connection for the project.

### Install PostgreSQL
Make sure you have PostgreSQL installed and running on your local machine or use a remote PostgreSQL server.

- You can download and install PostgreSQL from [here](https://www.postgresql.org/download/).

### 2. Configure the Database Connection

In the backend code, you'll find a PostgreSQL connection setup using the `pg` library and `Pool` from `pg` module. Update the connection parameters to match your environment.

```javascript
const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres', // Replace with your PostgreSQL username
  host: 'localhost', // Database server address (usually 'localhost' for local instances)
  database: 'your_database_name', // Replace with your PostgreSQL database name
  password: 'your_password', // Replace with your PostgreSQL password
  port: 5432, // Default port for PostgreSQL
});
```

## Contributing

1. Fork the repository.
2. Create a new branch
```
git checkout -b feature-name
```
3. Make your changes.
4. Commit your changes 
```
git commit -am 'Add new feature'
```
5. Push to the branch 
```
git push origin feature-name
```
6. Open a pull request.

## License

This project is licensed under the [MIT License](LICENSE).


