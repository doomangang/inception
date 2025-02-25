CREATE DATABASE mariadb;
CREATE USER 'jihyjeon'@'%' IDENTIFIED BY 'jihyjeon';

GRANT ALL PRIVILEGES ON mariadb.* TO 'jihyjeon'@'%';
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'jihyjeon';
