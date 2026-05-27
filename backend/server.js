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

const pool = mysql.createPool({

  host: "mysql",
  user: "root",
  password: "root123",
  database: "smartphone_yojna",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0

});

pool.getConnection((err, connection) => {

  if (err) {

    console.log("DB Connection Failed");
    console.log(err);

  } else {

    console.log("MySQL Connected");
    connection.release();

  }

});

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

  pool.query(sql, values, (err, result) => {

    if (err) {

      console.log(err);

      return res.status(500).json({
        success: false,
        error: err.message
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
