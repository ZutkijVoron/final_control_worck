DROP DATABASE IF EXISTS friendsOfMan;
CREATE DATABASE friendsOfMan;

USE friendsOfMan;

DROP TABLE IF EXISTS pets;
CREATE TABLE pets(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    animal VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS packAnimals;
CREATE TABLE packAnimals(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    animal VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS dogs;
CREATE TABLE dogs(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pets_id INT,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    FOREIGN KEY (pets_id) REFERENCES pets(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS cats;
CREATE TABLE cats(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pets_id INT,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    FOREIGN KEY (pets_id) REFERENCES pets(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS hamsters;
CREATE TABLE hamsters(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pets_id INT,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    FOREIGN KEY (pets_id) REFERENCES pets(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS horses;
CREATE TABLE horses(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pack_id INT,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    FOREIGN KEY (pack_id) REFERENCES packAnimals(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS camels;
CREATE TABLE camels(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pack_id INT,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    FOREIGN KEY (pack_id) REFERENCES packAnimals(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS donkeys;
CREATE TABLE donkeys(
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pack_id INT,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    FOREIGN KEY (pack_id) REFERENCES packAnimals(id) ON DELETE CASCADE
);

CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pet_id INT,
    pack_id INT,
    FOREIGN KEY (pet_id) REFERENCES pets(id) ON DELETE CASCADE,
    FOREIGN KEY (pack_id) REFERENCES packAnimals(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS friendsOfMan;
CREATE TABLE friendsOfMan (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    animal_id INT,
    FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE
);

INSERT INTO pets (animal) VALUES ('Dog'), ('Cat'), ('Hamster');
INSERT INTO packAnimals (animal) VALUES ('Horse'), ('Camel'), ('Donkey');

INSERT INTO dogs (pets_id, name_animal, commands, birth_date) VALUES
(1, 'Buddy', 'sit, stay, fetch', '2019-05-20'),
(1, 'Max', 'sit, come, roll over', '2018-11-15');

INSERT INTO cats (pets_id, name_animal, commands, birth_date) VALUES
(2, 'Whiskers', 'jump, play', '2020-03-10'),
(2, 'Fluffy', 'sleep, purr', '2017-08-22');

INSERT INTO hamsters (pets_id, name_animal, commands, birth_date) VALUES
(3, 'Nibbles', 'run, hide', '2021-01-05'),
(3, 'Tiny', 'spin, burrow', '2021-04-17');

INSERT INTO horses (pack_id, name_animal, commands, birth_date) VALUES
(1, 'Spirit', 'gallop, jump', '2015-06-12'),
(1, 'Thunder', 'race, trot', '2016-09-03');

INSERT INTO camels (pack_id, name_animal, commands, birth_date) VALUES
(2, 'Sandy', 'walk, carry', '2014-07-21'),
(2, 'Humpy', 'carry, sit', '2013-12-30');

INSERT INTO donkeys (pack_id, name_animal, commands, birth_date) VALUES
(3, 'Eeyore', 'bray, carry', '2012-10-10'),
(3, 'Mini', 'carry, follow', '2019-02-14');

DELIMITER $$
CREATE TRIGGER after_insert_animals
AFTER INSERT ON animals
FOR EACH ROW
BEGIN
    INSERT INTO friendsOfMan (animal_id) VALUES (NEW.id);
END$$
DELIMITER ;

INSERT INTO animals (pet_id, pack_id)
SELECT id, NULL
FROM pets;

INSERT INTO animals (pet_id, pack_id)
SELECT NULL, id
FROM packAnimals;

SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS camels;

DELETE FROM packAnimals
WHERE animal='Camel';

SET SQL_SAFE_UPDATES = 1;

DROP TABLE IF EXISTS combinedAnimals;
CREATE TABLE combinedAnimals LIKE horses;

INSERT INTO combinedAnimals (pack_id, name_animal, commands, birth_date)
SELECT pack_id, name_animal, commands, birth_date
FROM horses;

INSERT INTO combinedAnimals (pack_id, name_animal, commands, birth_date)
SELECT pack_id, name_animal, commands, birth_date
FROM donkeys;

DROP TABLE IF EXISTS horses;
DROP TABLE IF EXISTS donkeys;

CREATE TABLE young_animals (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name_animal VARCHAR(50) NOT NULL,
    commands VARCHAR(255),
    birth_date DATE NOT NULL,
    age_in_months INT
);

INSERT INTO young_animals (name_animal, commands, birth_date, age_in_months)
SELECT 
    c.name_animal, 
    c.commands, 
    c.birth_date, 
    TIMESTAMPDIFF(MONTH, c.birth_date, CURDATE()) AS age_in_months
FROM 
    combinedAnimals c
WHERE 
    TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE()) BETWEEN 1 AND 3
UNION
SELECT 
    d.name_animal, 
    d.commands, 
    d.birth_date, 
    TIMESTAMPDIFF(MONTH, d.birth_date, CURDATE()) AS age_in_months
FROM 
    dogs d
WHERE 
    TIMESTAMPDIFF(YEAR, d.birth_date, CURDATE()) BETWEEN 1 AND 3
UNION
SELECT 
    ct.name_animal, 
    ct.commands, 
    ct.birth_date, 
    TIMESTAMPDIFF(MONTH, ct.birth_date, CURDATE()) AS age_in_months
FROM 
    cats ct
WHERE 
    TIMESTAMPDIFF(YEAR, ct.birth_date, CURDATE()) BETWEEN 1 AND 3
UNION
SELECT 
    h.name_animal, 
    h.commands, 
    h.birth_date, 
    TIMESTAMPDIFF(MONTH, h.birth_date, CURDATE()) AS age_in_months
FROM 
    hamsters h
WHERE 
    TIMESTAMPDIFF(YEAR, h.birth_date, CURDATE()) BETWEEN 1 AND 3;

SELECT * FROM young_animals;

DROP TABLE IF EXISTS all_animals;
CREATE TABLE all_animals (
     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type VARCHAR(50) NOT NULL,
     name_animal VARCHAR(50) NOT NULL,
     commands VARCHAR(255),
     birth_date DATE NOT NULL,
    original_table VARCHAR(50)
 );

INSERT INTO all_animals (type, name_animal, commands, birth_date, original_table)
SELECT 'Dog', name_animal, commands, birth_date, 'dogs'
FROM dogs;

INSERT INTO all_animals (type, name_animal, commands, birth_date, original_table)
SELECT 'Cat', name_animal, commands, birth_date, 'cats'
FROM cats;

INSERT INTO all_animals (type, name_animal, commands, birth_date, original_table)
SELECT 'Hamster', name_animal, commands, birth_date, 'hamsters'
FROM hamsters;

INSERT INTO all_animals (type, name_animal, commands, birth_date, original_table)
SELECT 'Horse', name_animal, commands, birth_date, 'horses'
FROM combinedAnimals;

SELECT * FROM all_animals;