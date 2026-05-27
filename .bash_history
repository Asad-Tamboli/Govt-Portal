sudo apt update
ls
'ls

s

clear
ls
sudo usermod -aG kvm $USER
sudo apt install docker.io docker-compose-v2 -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu
docker --version
docker compose version
mkdir backend frontend mysql
touch docker-compose.yml
ls
cd ~/backend
vim server.js
vim package.json
vim Dockerfile
cd ..
cd frontend/
vim Dockerfile
vim index.html
vim index.html 
sed -i 's|13.235.45.67|YOUR_NEW_EC2_IP|g' ~/frontend/index.html
sed -i 's|13.235.45.67|32.197.180.193|g' ~/frontend/index.html
cd ~
docker compose up --build -d
cat > ~/docker-compose.yml << 'EOF'
services:

  mysql:
    image: mysql:8
    container_name: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: smartphone_yojna
    ports:
      - "3306:3306"

  backend:
    build: ./backend
    container_name: backend
    restart: always
    ports:
      - "5000:5000"
    depends_on:
      - mysql

  frontend:
    build: ./frontend
    container_name: frontend
    restart: always
    ports:
      - "80:80"
EOF

cat ~/docker-compose.yml
cd ~
docker compose up --build -d
sudo usermod -aG docker ubuntu
newgrp docker
cd ~
docker compose up --build -d
cat > ~/backend/Dockerfile << 'EOF'
FROM node:20-alpine

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
EOF

cat > ~/frontend/Dockerfile << 'EOF'
FROM nginx:alpine

COPY . /usr/share/nginx/html
EOF

cat ~/backend/Dockerfile
FROM nginx:alpine
cd ~
sudo docker compose up --build -d
docker [ps
docker ps
sudo docker compose down
cat > ~/backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "cors": "^2.8.5",
    "express": "^4.18.2",
    "mysql2": "^3.9.7"
  }
}
EOF

cat > ~/backend/Dockerfile << 'EOF'
FROM node:20-alpine

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
EOF

cat > ~/backend/server.js << 'EOF'
const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: "mysql",
  user: "root",
  password: "root123",
  database: "smartphone_yojna"
});

db.connect((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log("MySQL Connected");
  }
});

app.post("/submit", (req, res) => {
  const data = req.body;

  const sql =
    "INSERT INTO applications (full_name, mobile, aadhaar, email) VALUES (?, ?, ?, ?)";

  db.query(
    sql,
    [
      data.full_name,
      data.mobile,
      data.aadhaar,
      data.email
    ],
    (err, result) => {
      if (err) {
        console.log(err);
        return res.status(500).json({ success: false });
      }

      res.json({ success: true });
    }
  );
});

app.get("/", (req, res) => {
  res.send("Backend Running");
});

app.listen(5000, "0.0.0.0", () => {
  console.log("Backend running on port 5000");
});
EOF

cd ~
sudo docker compose up --build -d
docker ps
docker logs backend --tail 50
sudo docker restart backend
docker logs backend --tail 20
grep -n "fetch" ~/frontend/index.html
sed -i 's|YOUR_NEW_EC2_IP|32.197.180.193|g' ~/frontend/index.html
grep -n "fetch" ~/frontend/index.html
sudo docker compose up --build -d
docker logs backend 
docker logs frontend 
curl http://localhost:5000
grep -n "fetch" ~/frontend/index.html
fetch("http://32.197.180.193:5000/submit"
sudo docker compose build frontend
sudo docker compose up -d
docker logs -f backend
docker exec -it mysql mysql -u root -p
vim ~/backend/server.js
cat backend/server.js 
cd backend/
ls
vim server.js 
cd ~
sudo docker compose up --build -d
docker ps
docker exec -it mysql mysql -u root -p
sed -n '430,520p' ~/frontend/index.html
docker exec -it mysql mysql -u root -p
ls
cd backend/
ls
vim server.js 
cat server.js 
ls
rm -rf server.js 
ls
vim server.js
cat server.js 
cd ..
ls
cd frontend/
ls
vim index.html 
rm -rf index.html 
vim index.html
cd ~
sudo docker compose restart frontend backend
docker logs backend --tail 20
cd ~
sudo docker compose up --build -d
ls
docker ps
docker logs -f backend
nano ~/backend/server.js
cat backend/server.js 
nano ~/backend/server.js
cd ~
sudo docker compose up --build -d
docker restart backend
docker logs backend --tail 20
docker exec -it mysql mysql -u root -p
ls
cd frontend/
ls
cat index.html 
ls
rm index.html 
vim index.html 
cd ~
sudo docker compose down
sudo docker compose up --build -d
docker logs backend --tail 20
nano ~/docker-compose.yml
cat docker-compose.yml 
cd backend/
ls
cat server.js 
ls
[200~cd ~
sudo docker compose down~
cd ~
sudo docker compose down
sudo docker compose up --build -d
docker logs backend --tail 30
grep -n "connectWithRetry" ~/backend/server.js
cat > ~/backend/server.js << 'EOF'
const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();

app.use(cors());

app.use(express.json({
  limit: "50mb"
}));

app.use(express.urlencoded({
  extended: true,
  limit: "50mb"
}));

const db = mysql.createConnection({
  host: "mysql",
  user: "root",
  password: "root123",
  database: "smartphone_yojna"
});

function connectWithRetry() {

  db.connect((err) => {

    if (err) {

      console.log("MySQL not ready, retrying in 5 seconds...");
      console.log(err);

      setTimeout(connectWithRetry, 5000);

    } else {

      console.log("MySQL Connected");

    }

  });

}

connectWithRetry();

app.get("/", (req, res) => {

  res.send("Backend Running");

});

app.post("/submit", (req, res) => {

  const data = req.body;

  const sql = `
    INSERT INTO applications (
      full_name,
      dob,
      parent_name,
      single_parent_name,
      gender,
      marital_status,
      mobile,
      email,
      aadhaar,
      pan,
      qualification,
      college,
      course,
      percentage,
      employment_status,
      family_income,
      category,
      smartphone,
      address,
      district,
      state,
      pincode
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  const values = [
    data.full_name,
    data.dob,
    data.parent_name,
    data.single_parent_name,
    data.gender,
    data.marital_status,
    data.mobile,
    data.email,
    data.aadhaar,
    data.pan,
    data.qualification,
    data.college,
    data.course,
    data.percentage,
    data.employment_status,
    data.family_income,
    data.category,
    data.smartphone,
    data.address,
    data.district,
    data.state,
    data.pincode
  ];

  db.query(sql, values, (err, result) => {

    if (err) {

      console.log(err);

      return res.status(500).json({
        success: false
      });

    }

    res.json({
      success: true
    });

  });

});

app.listen(5000, "0.0.0.0", () => {

  console.log("Backend running on port 5000");

});
EOF

grep -n "connectWithRetry" ~/backend/server.js
docker ps
docker logs backend --tail 20
docker compose down -v
docker compose up --build -d
docker logs -f backend
docker restart backend frontend mysql 
docker logs -f
docker logs -f backend
docker logs mysql --tail 100
cd backend/
ls'
ls
ls'
ls
rm server.js 
vim server.js
cd ~
sudo docker compose down
sudo docker compose up --build -d
docker logs backend --tail 30
cd backend/
rm server.js 
vim server.js
ls
rm server.js 
vim server.js
cd ~
sudo docker compose down
sudo docker compose up --build -d
docker logs backend --tail 20
curl http://localhost:5000
grep -n "fetch(" ~/frontend/index.html
docker ps
docker restart cb09f1b8c26b
curl -X POST http://localhost:5000/submit -H "Content-Type: application/json" -d '{"full_name":"Test","mobile":"9999999999","aadhaar":"123412341234"}'
docker exec -it mysql mysql -u root -proot123
docker logs
docker logs backend af
docker logs backend
docker exec -it mysql mysql -u root -proot123
grep -n 'input type="text"' ~/frontend/index.html
ls
