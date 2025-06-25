drop database if exists todo;
create database todo;
use todo;
drop table if exists todotbl;

CREATE TABLE todotbl (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT FALSE,
    completed_date DATETIME NULL,
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
