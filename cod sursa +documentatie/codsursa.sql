DROP TABLE Autor_Carte CASCADE CONSTRAINTS;
DROP TABLE Imprumut CASCADE CONSTRAINTS;
DROP TABLE Exemplar CASCADE CONSTRAINTS;
DROP TABLE Sala CASCADE CONSTRAINTS;
DROP TABLE Carte CASCADE CONSTRAINTS;
DROP TABLE Autor CASCADE CONSTRAINTS;
DROP TABLE Domeniu CASCADE CONSTRAINTS;
DROP TABLE Editura CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Specializare CASCADE CONSTRAINTS;
DROP TABLE Facultate CASCADE CONSTRAINTS;


CREATE TABLE Facultate (
                           id_facultate INT PRIMARY KEY,
                           nume VARCHAR(50) NOT NULL
);

CREATE TABLE Specializare (
                              id_specializare INT PRIMARY KEY,
                              id_facultate INT NOT NULL,
                              nume VARCHAR(50) NOT NULL,
                              nr_ani INT CHECK (nr_ani BETWEEN 2 AND 6),
                              FOREIGN KEY (id_facultate) REFERENCES Facultate(id_facultate)
);

CREATE TABLE Student (
                         id_student INT PRIMARY KEY,
                         id_specializare INT NOT NULL,
                         nume VARCHAR(30) NOT NULL,
                         prenume VARCHAR(30) NOT NULL,
                         email VARCHAR(255) NOT NULL UNIQUE CHECK (email LIKE '%@%'),
                         nr_matricol VARCHAR(30) NOT NULL UNIQUE,
                         FOREIGN KEY (id_specializare) REFERENCES Specializare(id_specializare)
);

CREATE TABLE Editura (
                         id_editura INT PRIMARY KEY,
                         nume VARCHAR(128) NOT NULL,
                         localitate VARCHAR(50) NOT NULL,
                         tara VARCHAR(30) NOT NULL
);

CREATE TABLE Domeniu (
                         id_domeniu INT PRIMARY KEY,
                         nume VARCHAR(50) NOT NULL
);

CREATE TABLE Autor (
                       id_autor INT PRIMARY KEY,
                       nume VARCHAR(50) NOT NULL,
                       prenume VARCHAR(50),
                       tara VARCHAR(30) NOT NULL
);

CREATE TABLE Carte (
                       ISBN VARCHAR(13) PRIMARY KEY CHECK (LENGTH(ISBN) = 13),
                       id_editura INT NOT NULL,
                       id_domeniu INT NOT NULL,
                       titlu VARCHAR(255) NOT NULL,
                       anul_aparitiei INT CHECK (anul_aparitiei<=2026),
                       FOREIGN KEY (id_editura) REFERENCES Editura(id_editura),
                       FOREIGN KEY (id_domeniu) REFERENCES Domeniu(id_domeniu)
);

CREATE TABLE Sala (
                      id_sala INT PRIMARY KEY,
                      etaj INT NOT NULL
);

CREATE TABLE Exemplar (
                          cod_bare INT PRIMARY KEY,
                          ISBN VARCHAR(13) NOT NULL,
                          id_sala INT NOT NULL,
                          FOREIGN KEY (ISBN) REFERENCES Carte(ISBN) ON DELETE CASCADE,
                          FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Imprumut (
                          id_imprumut INT PRIMARY KEY,
                          id_student INT NOT NULL,
                          cod_bare INT NOT NULL,
                          FOREIGN KEY (id_student) REFERENCES Student(id_student) ON DELETE CASCADE,
                          FOREIGN KEY (cod_bare) REFERENCES Exemplar(cod_bare) ON DELETE CASCADE
);

CREATE TABLE Autor_Carte (
                             id_autor INT NOT NULL,
                             ISBN VARCHAR(13) NOT NULL,
                             PRIMARY KEY (id_autor, ISBN),
                             FOREIGN KEY (id_autor) REFERENCES Autor(id_autor) ON DELETE CASCADE,
                             FOREIGN KEY (ISBN) REFERENCES Carte(ISBN) ON DELETE CASCADE
);





INSERT INTO Sala (id_sala, etaj) VALUES (1, 1);
INSERT INTO Sala (id_sala, etaj) VALUES (2, 1);
INSERT INTO Sala (id_sala, etaj) VALUES (3, 2);
INSERT INTO Sala (id_sala, etaj) VALUES (4, 2);
INSERT INTO Sala (id_sala, etaj) VALUES (5, 3);
INSERT INTO Sala (id_sala, etaj) VALUES (6, 3);
INSERT INTO Sala (id_sala, etaj) VALUES (7, 4);
INSERT INTO Sala (id_sala, etaj) VALUES (8, 4);
INSERT INTO Sala (id_sala, etaj) VALUES (9, 5);
INSERT INTO Sala (id_sala, etaj) VALUES (10, 5);

INSERT INTO Facultate (id_facultate, nume) VALUES (1, 'Facultatea de Matematica si Informatica');
INSERT INTO Facultate (id_facultate, nume) VALUES (2, 'Facultatea de Medicina');
INSERT INTO Facultate (id_facultate, nume) VALUES (3, 'Facultatea de Drept');
INSERT INTO Facultate (id_facultate, nume) VALUES (4, 'Facultatea de Litere');
INSERT INTO Facultate (id_facultate, nume) VALUES (5, 'Facultatea de Istorie');
INSERT INTO Facultate (id_facultate, nume) VALUES (6, 'Facultatea de Biologie');
INSERT INTO Facultate (id_facultate, nume) VALUES (7, 'Facultatea de Chimie');
INSERT INTO Facultate (id_facultate, nume) VALUES (8, 'Facultatea de Fizica');
INSERT INTO Facultate (id_facultate, nume) VALUES (9, 'Facultatea de Psihologie');
INSERT INTO Facultate (id_facultate, nume) VALUES (10, 'Facultatea de Filosofie');

INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (1, 1, 'Informatica', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (2, 1, 'Matematica', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (3, 1, 'CTI', 4);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (4, 2, 'Medicina Generala', 6);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (5, 2, 'Medicina Dentara', 6);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (6, 3, 'Drept Civil', 4);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (7, 4, 'Filologie Engleza', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (8, 5, 'Istorie Antica', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (9, 6, 'Biochimie', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (10, 7, 'Chimie Organica', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (11, 8, 'Fizica Atomica', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (12, 9, 'Psihologie Cognitiva', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (13, 10, 'Etica Aplicata', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (14, 4, 'Traducere si Interpretare', 3);
INSERT INTO Specializare (id_specializare, id_facultate, nume, nr_ani) VALUES (15, 6, 'Ecologie', 3);

INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (1, 3, 'Matei', 'Pavel', 'pavel.matei@s.univ.ro', '50/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (2, 3, 'Nica', 'Razvan', 'razvan.nica@s.univ.ro', '42/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (3, 3, 'Ionescu', 'Andrei', 'andrei.ionescu@s.univ.ro', '90/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (4, 3, 'Popescu', 'Stefan', 'stefan.popescu@s.univ.ro', '60/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (5, 1, 'Filipescu', 'Andreea', 'andreea.filipescu@s.univ.ro', '80/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (6, 1, 'Sava', 'Stefan', 'stefan.sava@s.univ.ro', '81/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (7, 1, 'Marcu', 'Luca', 'luca.marcu@s.univ.ro', '82/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (8, 1, 'Iliescu', 'Maria', 'maria.iliescu@s.univ.ro', '60/2023');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (9, 2, 'Dedu', 'Bianca', 'bianca.dedu@s.univ.ro', '50/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (10, 2, 'Matei', 'Andrei', 'andrei.matei@s.univ.ro', '83/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (11, 2, 'Rosu', 'Stefan', 'stefan.rosu@s.univ.ro', '84/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (12, 4, 'Cojocaru', 'Vlad', 'vlad.cojocaru@s.univ.ro', '104/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (13, 4, 'Perjovschi', 'Artiom', 'artiom.perjovschi@s.univ.ro', '108/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (14, 4, 'Mogodeanu', 'Radu', 'radu.mogodeanu@s.univ.ro', '140/2023');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (15, 4, 'Camataru', 'Laura', 'laura.camataru@s.univ.ro', '160/2022');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (16, 5, 'Dinescu', 'Mircea', 'mircea.dinescu@s.univ.ro', '240/2023');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (17, 5, 'Maxim', 'Sabina', 'sabina.maxim@s.univ.ro', '260/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (18, 5, 'Stefan', 'Larisa', 'larisa.stefan@s.univ.ro', '250/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (19, 6, 'Popa', 'Alexandru', 'alex.popa@s.univ.ro', '300/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (20, 7, 'Radu', 'Elena', 'elena.radu@s.univ.ro', '310/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (21, 8, 'Dumitru', 'Ion', 'ion.dumitru@s.univ.ro', '320/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (22, 9, 'Stan', 'Maria', 'maria.stan@s.univ.ro', '330/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (23, 10, 'Gheorghe', 'Cristian', 'cristi.gheorghe@s.univ.ro', '340/2023');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (24, 11, 'Mihai', 'Ana', 'ana.mihai@s.univ.ro', '350/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (25, 12, 'Serban', 'Dan', 'dan.serban@s.univ.ro', '360/2024');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (26, 13, 'Lazar', 'Ioana', 'ioana.lazar@s.univ.ro', '370/2025');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (27, 14, 'Costea', 'George', 'george.costea@s.univ.ro', '380/2023');
INSERT INTO Student (id_student, id_specializare, nume, prenume, email, nr_matricol) VALUES (28, 15, 'Marin', 'Diana', 'diana.marin@s.univ.ro', '390/2024');

INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (1, 'Editura Tehnica Filaret', 'Bucuresti', 'Romania');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (2, 'Editura Universitatii Tehnice', 'Timisoara', 'Romania');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (3, 'Editura Medicala Asclepios', 'Galati', 'Romania');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (4, 'AP Press', 'Londra', 'UK');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (5, 'Humanitas', 'Bucuresti', 'Romania');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (6, 'Polirom', 'Iasi', 'Romania');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (7, 'Oxford University Press', 'Oxford', 'UK');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (8, 'Springer', 'Berlin', 'Germania');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (9, 'OReilly Media', 'California', 'SUA');
INSERT INTO Editura (id_editura, nume, localitate, tara) VALUES (10, 'Gallimard', 'Paris', 'Franta');

INSERT INTO Domeniu (id_domeniu, nume) VALUES (1, 'Matematica');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (2, 'Fizica');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (3, 'Chimie');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (4, 'Informatica');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (5, 'Drept');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (6, 'Medicina Generala');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (7, 'Chirurgie');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (8, 'Anatomie');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (9, 'Cardiologie');
INSERT INTO Domeniu (id_domeniu, nume) VALUES (10, 'Fiziologie');

INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (1, 'Ionescu', 'Sorin', 'Romania');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (2, 'Spencer', 'Diane', 'UK');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (3, 'Johnson', 'Andrew', 'SUA');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (4, 'Williams', 'Emily', 'Canada');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (5, 'Brown', 'Michael', 'SUA');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (6, 'Jones', 'Sarah', 'UK');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (7, 'Garcia', 'David', 'Spania');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (8, 'Martinez', 'Laura', 'Mexic');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (9, 'Bucurel', 'Florin', 'Romania');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (10, 'Lee', 'Yoon', 'Coreea de Sud');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (11, 'Popovici', 'Mihai', 'Romania');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (12, 'Smith', 'John', 'SUA');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (13, 'Muller', 'Hans', 'Germania');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (14, 'Dupont', 'Jean', 'Franta');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (15, 'Rossi', 'Alessandro', 'Italia');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (16, 'Chen', 'Wei', 'China');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (17, 'Silva', 'Carlos', 'Brazilia');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (18, 'Ivanov', 'Dmitri', 'Rusia');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (19, 'Sato', 'Kenji', 'Japonia');
INSERT INTO Autor (id_autor, nume, prenume, tara) VALUES (20, 'Kumar', 'Raj', 'India');

INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9783161484100', 1, 1, 'Geometrie Liniara Avansata', 2015);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9781234567890', 1, 1, 'Calcul Integral', 2018);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9782345678901', 1, 1, 'Ecuatii Diferentiale', 2020);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9783456789012', 2, 4, 'Dezvoltare Web', 2019);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9784567890123', 2, 4, 'Algoritmi de Baza', 2022);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9785678901234', 3, 6, 'Medicina Interna', 2017);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9786789012345', 3, 7, 'Chirurgie Generala', 2021);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9787890123456', 3, 8, 'Anatomie Descriptiva', 2016);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9788901234567', 4, 9, 'Advanced Cardiology', 2023);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9789012345678', 3, 10, 'Fiziologie Umana', 2014);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9781111111111', 5, 5, 'Drept Civil Roman', 2019);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9782222222222', 8, 2, 'Fizica Cuantica', 2021);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9783333333333', 8, 3, 'Chimie Organica Experimentala', 2020);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9784444444444', 9, 4, 'Inteligenta Artificiala', 2023);
INSERT INTO Carte (ISBN, id_editura, id_domeniu, titlu, anul_aparitiei) VALUES ('9785555555555', 6, 5, 'Teoria Generala a Dreptului', 2018);

INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (1, '9783161484100');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (9, '9783161484100');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (3, '9781234567890');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (5, '9782345678901');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (2, '9783456789012');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (6, '9783456789012');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (4, '9784567890123');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (7, '9785678901234');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (8, '9785678901234');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (10, '9785678901234');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (9, '9786789012345');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (1, '9787890123456');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (3, '9788901234567');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (5, '9789012345678');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (2, '9789012345678');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (11, '9781111111111');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (13, '9782222222222');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (12, '9782222222222');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (14, '9783333333333');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (15, '9783333333333');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (16, '9784444444444');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (19, '9784444444444');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (11, '9785555555555');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (17, '9781111111111');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (20, '9783456789012');
INSERT INTO Autor_Carte (id_autor, ISBN) VALUES (18, '9781234567890');

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1001, '9783161484100', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1002, '9783161484100', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1003, '9783161484100', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1004, '9783161484100', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1005, '9783161484100', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1006, '9783161484100', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1007, '9783161484100', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1008, '9783161484100', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1009, '9783161484100', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (1010, '9783161484100', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2001, '9781234567890', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2002, '9781234567890', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2003, '9781234567890', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2004, '9781234567890', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2005, '9781234567890', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2006, '9781234567890', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2007, '9781234567890', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2008, '9781234567890', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2009, '9781234567890', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (2010, '9781234567890', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3001, '9782345678901', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3002, '9782345678901', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3003, '9782345678901', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3004, '9782345678901', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3005, '9782345678901', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3006, '9782345678901', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3007, '9782345678901', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3008, '9782345678901', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3009, '9782345678901', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (3010, '9782345678901', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4001, '9783456789012', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4002, '9783456789012', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4003, '9783456789012', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4004, '9783456789012', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4005, '9783456789012', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4006, '9783456789012', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4007, '9783456789012', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4008, '9783456789012', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4009, '9783456789012', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (4010, '9783456789012', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5001, '9784567890123', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5002, '9784567890123', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5003, '9784567890123', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5004, '9784567890123', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5005, '9784567890123', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5006, '9784567890123', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5007, '9784567890123', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5008, '9784567890123', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5009, '9784567890123', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (5010, '9784567890123', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6001, '9785678901234', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6002, '9785678901234', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6003, '9785678901234', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6004, '9785678901234', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6005, '9785678901234', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6006, '9785678901234', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6007, '9785678901234', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6008, '9785678901234', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6009, '9785678901234', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (6010, '9785678901234', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7001, '9786789012345', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7002, '9786789012345', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7003, '9786789012345', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7004, '9786789012345', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7005, '9786789012345', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7006, '9786789012345', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7007, '9786789012345', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7008, '9786789012345', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7009, '9786789012345', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (7010, '9786789012345', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8001, '9787890123456', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8002, '9787890123456', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8003, '9787890123456', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8004, '9787890123456', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8005, '9787890123456', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8006, '9787890123456', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8007, '9787890123456', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8008, '9787890123456', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8009, '9787890123456', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (8010, '9787890123456', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9001, '9788901234567', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9002, '9788901234567', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9003, '9788901234567', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9004, '9788901234567', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9005, '9788901234567', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9006, '9788901234567', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9007, '9788901234567', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9008, '9788901234567', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9009, '9788901234567', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (9010, '9788901234567', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10001, '9789012345678', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10002, '9789012345678', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10003, '9789012345678', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10004, '9789012345678', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10005, '9789012345678', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10006, '9789012345678', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10007, '9789012345678', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10008, '9789012345678', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10009, '9789012345678', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (10010, '9789012345678', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11001, '9781111111111', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11002, '9781111111111', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11003, '9781111111111', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11004, '9781111111111', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11005, '9781111111111', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11006, '9781111111111', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11007, '9781111111111', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11008, '9781111111111', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11009, '9781111111111', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (11010, '9781111111111', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12001, '9782222222222', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12002, '9782222222222', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12003, '9782222222222', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12004, '9782222222222', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12005, '9782222222222', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12006, '9782222222222', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12007, '9782222222222', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12008, '9782222222222', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12009, '9782222222222', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (12010, '9782222222222', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13001, '9783333333333', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13002, '9783333333333', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13003, '9783333333333', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13004, '9783333333333', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13005, '9783333333333', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13006, '9783333333333', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13007, '9783333333333', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13008, '9783333333333', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13009, '9783333333333', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (13010, '9783333333333', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14001, '9784444444444', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14002, '9784444444444', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14003, '9784444444444', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14004, '9784444444444', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14005, '9784444444444', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14006, '9784444444444', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14007, '9784444444444', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14008, '9784444444444', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14009, '9784444444444', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (14010, '9784444444444', 10);

INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15001, '9785555555555', 1);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15002, '9785555555555', 2);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15003, '9785555555555', 3);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15004, '9785555555555', 4);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15005, '9785555555555', 5);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15006, '9785555555555', 6);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15007, '9785555555555', 7);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15008, '9785555555555', 8);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15009, '9785555555555', 9);
INSERT INTO Exemplar (cod_bare, ISBN, id_sala) VALUES (15010, '9785555555555', 10);

INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (1, 5, 1001);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (2, 6, 1002);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (3, 9, 2003);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (4, 10, 2004);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (5, 1, 3005);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (6, 2, 4006);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (7, 12, 6007);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (8, 13, 6008);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (9, 16, 7009);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (10, 17, 7010);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (11, 19, 11001);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (12, 19, 15002);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (13, 21, 12003);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (14, 21, 1004);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (15, 23, 13005);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (16, 28, 9006);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (17, 27, 2001);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (18, 4, 14008);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (19, 5, 14009);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (20, 24, 12010);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (21, 20, 8001);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (22, 14, 6002);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (23, 15, 7003);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (24, 25, 10004);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (25, 26, 15005);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (26, 22, 13006);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (27, 8, 5007);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (28, 8, 4008);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (29, 3, 14009);
INSERT INTO Imprumut (id_imprumut, id_student, cod_bare) VALUES (30, 18, 10010);
commit;


