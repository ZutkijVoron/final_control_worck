drop database if exists friendsOfMan;
create database friendsOfMan;

use friendsOfMan;

drop table if exists pets;
create table pets(
id int auto_increment primary key not null,
animal varchar(50) not null
);

drop table if exists packAnimals;
create table packAnimals(
id int auto_increment primary key not null,
animal varchar(50) not null
);

drop table if exists dogs;
create table dogs(
id int auto_increment primary key not null,
pets_id int,
name_animal varchar(50) not null,
commands varchar(255),
birth_date date not null,
foreign key(pets_id) references pets(id)
);
drop table if exists cats;
create table cats(
id int auto_increment primary key not null,
pets_id int,
name_animal varchar(50) not null,
commands varchar(255),
birth_date date not null,
foreign key(pets_id) references pets(id)
);
drop table if exists hamsters;
create table hamsters(
id int auto_increment primary key not null,
pets_id int,
name_animal varchar(50) not null,
commands varchar(255),
birth_date date not null,
foreign key(pets_id) references pets(id)
);
drop table if exists horses;
create table horses(
id int auto_increment primary key not null,
pack_id int,
name_animal varchar(50) not null,
commands varchar(255),
birth_date date not null,
foreign key(pack_id) references packAnimals(id)
);
drop table if exists camels;
create table camels(
id int auto_increment primary key not null,
pack_id int,
name_animal varchar(50) not null,
commands varchar(255),
birth_date date not null,
foreign key(pack_id) references packAnimals(id)
);
drop table if exists donkeys;
create table donkeys(
id int auto_increment primary key not null,
pack_id int,
name_animal varchar(50) not null,
commands varchar(255),
birth_date date not null,
foreign key(pack_id) references packAnimals(id)
);

CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    pet_id int,
    pack_id int,
    foreign key (pet_id) references pets(id),
    foreign key (pack_id) references packAnimals(id)
);

DROP TABLE IF EXISTS friendsOfMan;
CREATE TABLE friendsOfMan (
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
animal_id int,
foreign key (animal_id) references animals(id)
);
insert into pets (animal) values ('Dog'), ('Cat'), ('Hamster');
insert into packAnimals (animal) values ('Horse'), ('Camel'), ('Donkey');
insert into dogs (pets_id, name_animal, commands, birth_date) values
(1, 'Buddy', 'sit, stay, fetch', '2019-05-20'),
(1, 'Max', 'sit, come, roll over', '2018-11-15');
insert into cats (pets_id, name_animal, commands, birth_date) values
(2, 'Whiskers', 'jump, play', '2020-03-10'),
(2, 'Fluffy', 'sleep, purr', '2017-08-22');
insert into hamsters (pets_id, name_animal, commands, birth_date) values
(3, 'Nibbles', 'run, hide', '2021-01-05'),
(3, 'Tiny', 'spin, burrow', '2021-04-17');
insert into horses (pack_id, name_animal, commands, birth_date) values
(1, 'Spirit', 'gallop, jump', '2015-06-12'),
(1, 'Thunder', 'race, trot', '2016-09-03');
insert into camels (pack_id, name_animal, commands, birth_date) values
(2, 'Sandy', 'walk, carry', '2014-07-21'),
(2, 'Humpy', 'carry, sit', '2013-12-30');
insert into donkeys (pack_id, name_animal, commands, birth_date) values
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
;
INSERT INTO animals (pet_id, pack_id) select null, id from packAnimals;