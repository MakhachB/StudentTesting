DROP TABLE IF EXISTS decisions;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS tests;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS test_category;

CREATE TABLE users (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    first_name varchar(30) NOT NULL ,
    last_name varchar(30) NOT NULL ,
    login varchar(30) NOT NULL UNIQUE ,
    email varchar(100) NOT NULL UNIQUE ,
    password varchar(100) NOT NULL ,
    year_of_birth date NOT NULL CHECK ( year_of_birth > '1900-01-01' ),
    time_of_registration timestamp NOT NULL ,
    role varchar(30) NOT NULL
);


CREATE TABLE test_category (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    title varchar(100)
);

CREATE TABLE tests (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    title varchar(100) NOT NULL ,
    category_id int REFERENCES test_category(id),
    count_of_questions smallint NOT NULL CHECK ( count_of_questions > 0 ) ,
    count_of_decisions int DEFAULT 0,
    date_of_creation date NOT NULL CHECK ( date_of_creation > '2022-06-01' ),
    users_id int REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE questions (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    title text,
    number_of_question smallint NOT NULL ,
    correct_answer_id smallint NOT NULL ,
    first_answer varchar(100) NOT NULL ,
    second_answer varchar(100) NOT NULL ,
    third_answer varchar(100) DEFAULT NULL ,
    fourth_answer varchar(100) DEFAULT NULL ,
    tests_id int REFERENCES tests(id) ON DELETE CASCADE
);

CREATE TABLE decisions (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY ,
    users_id int REFERENCES users(id) ON DELETE CASCADE ,
    tests_id int REFERENCES tests(id) ON DELETE SET NULL ,
    time_of_decision timestamp NOT NULL ,
    count_of_right_answers smallint NOT NULL ,
    count_of_all_answers smallint NOT NULL
);

INSERT INTO users(first_name, last_name, login, email, password, year_of_birth, time_of_registration, role) VALUES
-- Пароль у всех "12345"
('Джек', 'Смит', 'jack23', 'jack@mail.com', '$2a$10$sINGL2w4dlvwVsQ.Z7wt0.BmMMDal7HRum31Ax91wwdr4v6HUAF6a', '2000-10-20', '2022-07-01 20:05:06', 'ROLE_USER'),
('Иван', 'Иванов', 'ivan45', 'ivan@mail.com', '$2a$10$sINGL2w4dlvwVsQ.Z7wt0.BmMMDal7HRum31Ax91wwdr4v6HUAF6a', '2003-11-20', '2022-07-03 20:03:06', 'ROLE_USER'),
('Майк', 'Джексон', 'mike2', 'mike@mail.com', '$2a$10$sINGL2w4dlvwVsQ.Z7wt0.BmMMDal7HRum31Ax91wwdr4v6HUAF6a', '1981-10-20', '2022-07-02 16:00:06', 'ROLE_TEACHER'),
('Эндрю', 'Пол', 'andrew3', 'andrew@mail.com', '$2a$10$sINGL2w4dlvwVsQ.Z7wt0.BmMMDal7HRum31Ax91wwdr4v6HUAF6a', '1995-10-20', '2022-07-08 04:05:06', 'ROLE_ADMIN');


INSERT INTO test_category(title) VALUES
('Математика'),
('Биология'),
('Информатика'),
('Русский язык'),
('Физика'),
('Химия'),
('Литература'),
('Иностранный'),
('История');

INSERT INTO tests(title, category_id, count_of_questions, date_of_creation, users_id) VALUES
('Анатомия', 2, 2, '2022-07-01', 3),
('Математика 11 класс', 1, 3, '2022-07-03', 3),
('Астрономия', 5, 3, '2022-07-04', 3),
('Русский язык для 8 класса', 4, 3, '2022-07-05', 3);


INSERT INTO questions (title, number_of_question, correct_answer_id, first_answer, second_answer, third_answer, fourth_answer, tests_id) VALUES
('First question of Biology', 1, 3, 'first', 'second', 'thirdR', 'fourth', 1),
('Second question of Biology', 2, 1, 'firstR', 'second', 'third', 'fourth', 1),
('First question of Math', 1, 2, 'first', 'secondR', 'third', 'fourth', 2),
('Second question of Math', 2, 4, 'first', 'second', 'third', 'fourthR', 2),
('Second question of Math', 3, 4, 'first', 'second', 'third', 'fourthR', 2),
('Название 5-ой планеты от солнца',1,2,'Земля','Юпитер','Сатурн','Марс',3),
('Примерное расстояние Земли от Луны',2,2,'200000 км','400000 км','1000000 км','80000 км',3),
('Примерный диаметр земли',3,3,'3000 км','6000 км','12 000 км','4500 км',3),
('Стекля__ый',1,2,'н','нн','ничего','Не знаю правильного ответа',4),
('Флаг разв_вается',2,2,'и','е','ничего','Не знаю правильного ответа',4),
('Их__ решение',3,3,'нее','ний','ничего','Не знаю правильного ответа', 4);

INSERT INTO decisions(users_id, tests_id, time_of_decision, count_of_right_answers, count_of_all_answers) VALUES
(1, 1, '2022-07-08 04:05:06', 1, 2),
(1, 2, '2022-07-09 22:05:06', 3, 3),
(2, 2, '2022-07-09 21:02:06', 2, 3),
(2, 3, '2022-07-09 21:07:08', 2, 3);


