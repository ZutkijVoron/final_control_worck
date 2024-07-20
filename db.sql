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
DROP TABLE IF EXISTS friendsOfMan;
CREATE TABLE friendsOfMan (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    animal_id INT NOT NULL,
    foreign key (animal_id) references pets(id),
    foreign key (animal_id) references packAnimals(id)
);
