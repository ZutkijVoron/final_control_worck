# final_control_worck


1. Используя команду cat в терминале операционной системы Linux, создать
два файла Домашние животные (заполнив файл собаками, кошками,
хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и
ослы), а затем объединить их. Просмотреть содержимое созданного файла.
Переименовать файл, дав ему новое имя (Друзья человека).

- cat > pets

Собака1

Собака2

Собака3

Кошка1

Кошка2

Кошка3

Хомяк1

Хомяк2

Хомяк3

ctrl + d

- cat > packAnimals

Лошадь1

Лошадь2

Лошадь3

Верблюд1

Верблюд2

Верблюд3

Осёл1

Осёл2

Осёл3

ctrl + d

- cat packAnimals pets > friendsOfMan

2. Создать директорию, переместить файл туда.

- mkdir assets

- mv ./friendsOfMan ./assets/

3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.

- wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb

- sudo apt install ./mysql-apt-config_0.8.12-1_all.deb

- sudo apt update

- sudo apt install mysql-server

4. Установить и удалить deb-пакет с помощью dpkg

- wget
https://download.docker.com/linux/ubuntu/dists/jammy/pool/test/amd64/docker-ce_26.1.3-1~ubuntu.22.04~jammy_amd64.deb
- sudo apt update
- sudo apt install -y libltdl7
- sudo dpkg -i docker-ce_26.1.3-1~ubuntu.22.04~jammy_amd64.deb
- sudo apt install -f





