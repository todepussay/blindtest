CREATE DATABASE IF NOT EXISTS `blindtest` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `blindtest`;

CREATE TABLE t_user (
    id_user INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    pp VARCHAR(50) NOT NULL DEFAULT "default.png",
    bio VARCHAR(50),
    discord VARCHAR(50),
    anilist VARCHAR(50),
    twitter VARCHAR(50),
    profil_id INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_user),
    FOREIGN KEY (profil_id) REFERENCES t_profil(id_profil)
);

CREATE TABLE t_profil (
    id_profil INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_profil)
);

CREATE TABLE t_categorie (
    id_categorie INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_categorie)
);

CREATE TABLE t_origine (
    id_origine INT NOT NULL AUTO_INCREMENT,
    categorie_id INT NOT NULL,
    nom_origine VARCHAR(50) NOT NULL,
    annee_origine INT NOT NULL,
    PRIMARY KEY (id_origine),
    FOREIGN KEY (categorie_id) REFERENCES t_categorie(id_categorie)
);

CREATE TABLE t_sound (
    id_sound INT NOT NULL AUTO_INCREMENT,
    origine_id INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    number INT NOT NULL DEFAULT 1,
    top100 BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (id_sound),
    FOREIGN KEY (origine_id) REFERENCES t_origine(id_origine)
);

CREATE TABLE t_score (
    id_score INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    categorie_id INT NOT NULL,
    score INT NOT NULL DEFAULT 0,
    len INT NOT NULL DEFAULT 10,
    params VARCHAR(200) NOT NULL DEFAULT "default",
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_score),
    FOREIGN KEY (user_id) REFERENCES t_user(id_user),
    FOREIGN KEY (categorie_id) REFERENCES t_categorie(id_categorie)
);

CREATE TABLE t_question (
    id_question INT NOT NULL AUTO_INCREMENT,
    categorie_id INT NOT NULL,
    question VARCHAR(200) NOT NULL,
    level INT NOT NULL DEFAULT 1,
    target VARCHAR(50) NOT NULL,
    appear INT NOT NULL DEFAULT 1,
    point INT NOT NULL DEFAULT 1,
    chance INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_question),
    FOREIGN KEY (categorie_id) REFERENCES t_categorie(id_categorie)
);

INSERT INTO t_profil (name) VALUES ("Utilisateur"), ("Administrateur");
INSERT INTO t_user (username, email, password, profil_id) VALUES ("admin", "admin@gmail.com" , "admin", 2);