const express = require('express');
const app = express();
require('dotenv').config();
port = process.env.PORT || 5000;
const cors = require('cors');
const bodyParser = require('body-parser');
const mysql = require('mysql2');

app.use(cors());
app.use(bodyParser.json());

// Create connection
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
});

app.get("/api/login", (req, res) => {
    const sql = "SELECT id_user, username, email, pp FROM t_user WHERE email = ? AND password = ?";

    const { email, password } = req.query;

    db.query(sql, [email, password], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send({user: result[0]});
        }
    })

})

app.post("/api/register", (req, res) => {
    const sql = "INSERT INTO t_user (username, email, password) VALUES (?, ?, ?)";
    
    const { username, email, password } = req.body;

    db.query(sql, [username, email, password], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send({user: result});
        }
    })
});

app.get("/api/user/:id", (req, res) => {
    const sql = "SELECT id_user, username, pp, bio, discord, twitter, twitch FROM t_user WHERE id_user = ?";

    const { id } = req.params;

    db.query(sql, [id], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send({user: result[0]});
        }
    })

    console.log("Récupération du profil de l'utilisateur " + id);
});

app.get("/api/user/:id/activity", (req, res) => {
    const sql = `
    SELECT name, id_score, score, date
    FROM t_score, t_categorie
    WHERE t_score.categorie_id = t_categorie.id_categorie
    AND user_id = ?
    ORDER BY date DESC
    `;

    const { id } = req.params;

    db.query(sql, [id], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send({userActivity: result});
        }
    })
})

app.get("/api/users", (req, res) => {
    const sql = "SELECT id_user, username, pp FROM t_user WHERE username LIKE ?";

    const username = "%" + req.query.search + "%";

    db.query(sql, [username], (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send({users: result});
        }
    })
})

app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})