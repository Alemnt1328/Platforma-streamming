-- Crearea bazei de date
DROP DATABASE IF EXISTS program;
CREATE DATABASE program;
USE program;

-- Crearea tabelului clienti
CREATE TABLE clienti (
    cod_clienti VARCHAR(5) PRIMARY KEY,
    nume VARCHAR(30) NOT NULL,
    prenume VARCHAR(30) NOT NULL,
    data_nastere DATE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL
);

-- Crearea tabelului cont
CREATE TABLE cont (
    id_cont INT AUTO_INCREMENT PRIMARY KEY,
    cod_clienti VARCHAR(5),
    nume VARCHAR(50) UNIQUE NOT NULL,
    data_creare DATE NOT NULL,
    parola VARCHAR(16) NOT NULL,
    CONSTRAINT fk_clienti_cont FOREIGN KEY (cod_clienti) REFERENCES clienti (cod_clienti) on delete cascade
    
);

-- Crearea tabelului articol
CREATE TABLE articol (
    id_articol INT AUTO_INCREMENT PRIMARY KEY,
    tip ENUM('film', 'serial') NOT NULL
);

-- Crearea tabelului categorie
CREATE TABLE categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    id_cont INT,
    denumire_categorie VARCHAR(50),
    nivel_popularitate INT,
    FOREIGN KEY (id_cont) REFERENCES cont(id_cont)
);

-- Crearea tabelului film
CREATE TABLE film (
    id_articol INT,
    id_categorie INT,
    nume_film VARCHAR(50),
    data_lansare DATE NOT NULL,
    durata DECIMAL(5, 2) NOT NULL,
    actori VARCHAR(3000),
    regizor VARCHAR(50),
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie),
    FOREIGN KEY (id_articol) REFERENCES articol(id_articol)
);

-- Crearea tabelului seriale
CREATE TABLE seriale (
    id_serial INT AUTO_INCREMENT PRIMARY KEY,
    id_articol INT,
    id_categorie INT,
    nume_serial VARCHAR(50),
    nr_sezoane INT(2),
    lansare_initiale DATE NOT NULL,
    FOREIGN KEY (id_articol) REFERENCES articol(id_articol),
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
);

-- Crearea tabelului sezon
CREATE TABLE sezon (
    id_sezon INT AUTO_INCREMENT PRIMARY KEY,
    id_serial INT,
    nr_sezon INT,
    data_lansare DATE NOT NULL,
    actori VARCHAR(1000),
    regizor VARCHAR(50),
    FOREIGN KEY (id_serial) REFERENCES seriale(id_serial)
);

-- Crearea tabelului episod
CREATE TABLE episod (
    id_episod INT AUTO_INCREMENT PRIMARY KEY,
    id_sezon INT,
    nr_episod INT,
    nr_sezon INT,
    nume VARCHAR(100),
    durata DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (id_sezon) REFERENCES sezon(id_sezon)
);

-- Inserare în tabelul clienti
INSERT INTO clienti (cod_clienti, nume, prenume, data_nastere, email) VALUES 
('C001', 'Popescu', 'Daria', '2002-03-22', 'dariaexamplepopescu@gmail.ro'),
('C002', 'Ionescu', 'Marin', '1967-01-03', 'marini67@yahoo.com'),
('C003', 'Radu', 'Alex', '2000-02-01', 'alexexample@gmail.ro'),
('C004', 'Matei', 'Raluca', '1989-01-13', 'bdkszhsu@yahoo.com');

-- Inserare în tabelul cont
INSERT INTO cont (cod_clienti, nume, data_creare, parola) VALUES 
('C001', 'Daria1', '2020-05-06', 'del'),
('C002', 'Marinel', '2021-04-27', 'del'),
('C003', 'Alex', '2021-05-06', 'del'),
('C004', 'Raluca', '2020-04-27', 'del');

-- Inserare categorii
INSERT INTO categorie (id_cont, denumire_categorie, nivel_popularitate) VALUES 
(1, 'Actiune', 5),
(1, 'Animatie', 4),
(1, 'Drama', 4),
(1, 'Mystery', 3),
(1, 'Romantic', 3),
(1, 'Horror', 5);

-- Inserare filme
INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES 
(last_insert_id(), 1, 'Bad boys', '1995-04-07', 118.6, 'Martin Lawrence/Marcus Burnett, Will Smith/Mike Lowrey, Theresa Randle/Theresa Burnett', 'Michael Bay');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES 
(last_insert_id(),1, 'Bad boys 2', '2003-07-18', 147.00, 'Martin Lawrence/Marcus Burnett, Will Smith/Mike Lowrey, Theresa Randle/Theresa Burnett', 'Michael Bay');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES 
(last_insert_id(),1, 'Spider-man', '2002-04-29', 121.00, 'Tobey Maguire/Peter Parker, Willem Dafoe/Norman Osborn, Kirsten Dunst/Mary Jane Watson, James Franco/Harry Osborn', 'Sam Raimi');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),1, 'Spider-man No Way Home', '2021-12-17', 148.00, 'Tom Holland/Peter Parker, Zendaya/MJ, Benedict Cucumberbatch/Doctor Strange, Jon Favreau/Happy Hogan, Willem Dafoe/Norman Osborn', 'Jon Watts'); 

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),6, 'Jigsaw', '2017-10-27', 92.00, 'Matt Passmore/Logan Nelson, Tobin Bell/Jigsaw, Callum Keith Rennie/Detective Halloran', 'Michael Spierig and Peter Spierig');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),2,'Kung Fu Panda 4', '2024-03-08', 92.00, 'Jack Black/Po, Awkwafina/Zhen, Viola Davis/The Chameleon, Dustin Hoffman/Shifu', 'Mike Mitchell and Stephanie Stine');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),5, 'Titanic', '1997-12-19', 194.00, 'Leonardo DiCaprio/Jack Dawson, Kate Winslet/Rose Dewitt Bukater, Billy Zane/Cal Hockley, Kathy Bates/Molly Brown', 'James Cameron');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),2, 'Frozen', '2014-11-19', 102.00, 'Kristen Bell/Anna, Idina Menzel/Elsa, Jonathan Groff/Kristoff, Josh Gad/Olaf', 'Chris Buck and Jennifer Lee');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),3, 'Locked in', '2023-11-01', 96.00, 'Famke Janssen/Katherine, Rose Williams/Lina, Alex Hassell/Doctor Lawrence, Finn Cole/Jamie', 'Nour Wazzi');

INSERT INTO articol (tip) VALUES ('film');
INSERT INTO film (id_articol, id_categorie, nume_film, data_lansare, durata, actori, regizor) VALUES  
(last_insert_id(),3,'Oppenheimer', '2023-07-21', 180.00, 'Cillian Murphy/J. Robert Oppenheimer, Emily Blunt/Kitty Oppenheimer, Robert Downey Jr./Lewis Strauss', 'Christopher Nolan');


-- Inserare seriale
-- The Queen`s Gambit
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES 
(last_insert_id(), 3, 'The Queen`s Gambit',1, '2020-10-23');
            
INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1,'2020-10-23','Anya Taylor-Joy/Beth Harmon, Harry Melling/Harry Beltik, Thomas Brodie-Sangster/Benny Watts, Marielle Heller/Alma Wheatley, Moses Ingram/Jolene, Bill Camp/Mr. Shaibel','Scott Frank');

INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
(last_insert_id(), 1, 1,'Openings', '59'),
(last_insert_id(), 1, 2,'Exchanges', '65'),
(last_insert_id(), 1, 3,'Double Pawns', '46'),
(last_insert_id(), 1, 4,'Middle Game', '48'),
(last_insert_id(), 1, 5,'Fork', '48'),
(last_insert_id(), 1, 6,'Adjournment', '60'),
(last_insert_id(), 1, 7,'End game', '68');		
            
-- One of us is lying
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES 
(last_insert_id(), 4,'One of us is lying',2, '2020-10-23');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1,'2021-10-7','Chibuikem Uche/Cooper Clay, Marianly Tejada/Bronwyn Rojas, Cooper van Grootel/Nate Macauley, Jess McLeod/Janae Matthews, Melissa Collazo/Maeve Rojas, Sara Thompson/Vanessa Merriman','Jennifer Morrison'),
(last_insert_id(), 2,'2021-10-7','Chibuikem Uche/Cooper Clay, Marianly Tejada/Bronwyn Rojas, Cooper van Grootel/Nate Macauley, Jess McLeod/Janae Matthews, Melissa Collazo/Maeve Rojas, Sara Thompson/Vanessa Merriman','Jennifer Morrison');

INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
-- sezonul 1
(last_insert_id(), 1, 1,'Pilot', '47'),
(last_insert_id(), 1, 2,'One of us is grieving', '49'),
(last_insert_id(), 1, 3,'One of us is note like the others', '49'),
(last_insert_id(), 1, 4,'One of us is famous', '46'),
(last_insert_id(), 1, 5,'One of us is craking', '48'),
(last_insert_id(), 1, 6,'One of us is dancing', '50'),
(last_insert_id(), 1, 7,'One of us is not giving up', '45'),
(last_insert_id(), 1, 8,'One of us is dead', '52'),
            
-- Sezonul 2
(last_insert_id(), 2, 1, 'Simon says Game on', '46'),
(last_insert_id(), 2, 2, 'Simon says tick tock', '52'),
(last_insert_id(), 2, 3, 'Simon says let`s get personal', '50'),
(last_insert_id(), 2, 4, 'Simon says gotcha!', '50'),
(last_insert_id(), 2, 5, 'Simon says ho ho ho', '51'),
(last_insert_id(), 2, 6, 'Simon says you better pray', '50'),
(last_insert_id(), 2, 7, 'Simon says time out', '42'),
(last_insert_id(), 2, 8, 'Simon says game over','50');

-- Bridgerton
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 5,'Bridgerton',2, '2020-12-25');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1,'2020-12-25','Nicola Coughlan/Penelope Featherington, Luke Newton/Colin Bridgerton, Claudia Jessie/Eloise Bridgerton, Luke Thompson/Benedict Bridgerton, Adjoa Andoh/Lady Agatha Danbury, Jonathan Bailey/Lord Anthony Bridgerton','Tom Verica'),
(last_insert_id(), 2,'2022-05-25','Nicola Coughlan/Penelope Featherington, Luke Newton/Colin Bridgerton, Claudia Jessie/Eloise Bridgerton, Luke Thompson/Benedict Bridgerton, Adjoa Andoh/Lady Agatha Danbury, Jonathan Bailey/Lord Anthony Bridgerton','Tom Verica');
			
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
 -- Sezon 1
(last_insert_id(),1,1,'Diamond of the First Water', '58'),
(last_insert_id(),1,2,'Shock and Delight', '62'),
(last_insert_id(),1,3,'Art of the Swoon', '57'),
(last_insert_id(),1,4,'An Affair of Honor', '61'),
(last_insert_id(), 1,5,'The Duke and I', '61'),
(last_insert_id(), 1,6,'Swish', '57'),
(last_insert_id(), 1,7,'Ocean part', '61'),
(last_insert_id(), 1,8,'After the Rain', '73'),

-- Bridgerton sezon 2
(last_insert_id(), 2, 1,'Capital R Rake', '70'),
(last_insert_id(), 2, 2,'Off to the Races', '53'),
(last_insert_id(), 2, 3,'A Bee in Your Bonnet', '68'),
(last_insert_id(), 2, 4,'Victory', '58'),
(last_insert_id(), 2, 5,'An Unthinkable Fate', '58'),
(last_insert_id(), 2, 6,'The Choice', '69'),
(last_insert_id(), 2, 7,'Harmony', '59'),
(last_insert_id(), 2, 8,'The Viscount Who Loved Me','71');

-- Wednesday
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 4, 'Wednesday', 1,'2022-11-23');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1,'2022-11-23','Jenna Ortega/Wednesday Addams, Emma Myers/Enid Sinclair, Percy Hynes White/Xavier Thorpe, Hunter Doohan/Tyler Galpin, Gwendoline Christie/Larissa Weems,Luis Guzmán/Gomez Addams, Catherine Zeta-Jones/Morticia Addams', 'Tin Burton');

INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
(last_insert_id(), 1, 1, 'Wednesday`s Child Is Full of Woe', 59),
(last_insert_id(), 1, 2, 'Woe Is the Loneliest Number', 48),
(last_insert_id(), 1, 3, 'Friend or Woe', 48),
(last_insert_id(), 1, 4, 'Woe What a Night', 49),
(last_insert_id(), 1, 5, 'You Reap What You Woe', 52),
(last_insert_id(), 1, 6, 'Quid Pro Woe', 50),
(last_insert_id(), 1, 7, 'If You Don`t Woe Me by Now', 47),
(last_insert_id(), 1, 8, 'A Murder of Woes', 56);

-- Teen Titans
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 2, 'Teen Titans', 3,'2003-07-22');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(),1, '2003-07-19','Scott Menville/Robin, Greg Cipes/Beast Boy, Tara Strong/Raven, Khary Payton/Cyborg, Hynden Walch/Starfire', 'Glen Murakami'),
(last_insert_id(), 2, '2004-01-10', 'Scott Menville/Robin, Greg Cipes/Beast Boy, Tara Strong/Raven, Khary Payton/Cyborg, Hynden Walch/Starfire', 'Glen Murakami'),
(last_insert_id(), 3, '2004-08-28', 'Scott Menville/Robin, Greg Cipes/Beast Boy, Tara Strong/Raven, Khary Payton/Cyborg, Hynden Walch/Starfire', 'Glen Murakami');
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
-- Teen Titans sezon 1
(last_insert_id(),1,1,'Final Exam', 22),
(last_insert_id(),1,2,'Sisters', 21),
(last_insert_id(),1,3,'Divide and Conquere', 22),
(last_insert_id(),1,4,'Forces of Nature', 23),
(last_insert_id(),1,5,'The sum of His Parts', 23),
(last_insert_id(),1,6,' Nevermore', 22),
(last_insert_id(),1,7,'Switched', 24),
(last_insert_id(),1,8,'Deep Six', 22),
(last_insert_id(),1,9,'Masks', 21),
(last_insert_id(),1,10,'Mad Mood', 22),
(last_insert_id(),1,11,' Apprentice: Part 1', 23),
(last_insert_id(),1,12,' Apprentice: Part 2', 23),
(last_insert_id(),1,13,'Car Trouble', 22),
			
-- Teen Titans sezon 2
(last_insert_id(),2,1,'How Long is Forever?', 21),
(last_insert_id(),2,2,'Every Dog Has His Day', 22),
(last_insert_id(),2,3,'Terra', 23),
(last_insert_id(),2,4,'Only Human', 22),
(last_insert_id(),2,5,'Fear Itself', 22),
(last_insert_id(),2,6,'Date with Destiny', 21),
(last_insert_id(),2,7,'Transformation ', 22),
(last_insert_id(),2,8,'Titan Rising', 23),
(last_insert_id(),2,9,'Winner Take All', 23),
(last_insert_id(),2,10,'Betrayal', 21),
(last_insert_id(),2,11,'Fractured', 22),
(last_insert_id(),2,12,'Aftershock: Part 1', 21),
(last_insert_id(),2,13,'Aftershock: Part 2', 23),
            
-- Teen Titans sezon 3
(last_insert_id(),3,1,'Deception', 22),
(last_insert_id(),3,2,'X', 23),
(last_insert_id(),3,3,'Betrothed', 24),
(last_insert_id(),3,4,'Crash ', 21),
(last_insert_id(),3,5,'Haunted ', 22),
(last_insert_id(),3,6,'Spellbound', 22),
(last_insert_id(),3,7,'Revolution ', 24),
(last_insert_id(),3,8,'Wavelenght', 23),
(last_insert_id(),3,9,'The Beast Within', 22),
(last_insert_id(),3,10,'Can I Keep Him?', 22),
(last_insert_id(),3,11,'Bunny Raven or How to Make a Titananimal Disappear', 22),
(last_insert_id(),3,12,'Titans East: Part 1', 21),
(last_insert_id(),3,13,'Titans East: Part 2', 22);
            
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 4, 'Lupin', 3, '2021-01-08');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1, '2021-01-08', 'Omar Sy/Assane Diop, Shirine Boutella/Lieutenant Sofia Belkacem, Ludivine Sagnier/Claire, Ludmilla Makowski/Claire, Soufiane Guerrab/Youssef Guedira, Clotilde Hesme/Juliette Pellegrini, Etan Simon/Raoul', 'Marcela Said'),
(last_insert_id(), 2, '2021-06-11', 'Omar Sy/Assane Diop, Shirine Boutella/Lieutenant Sofia Belkacem, Ludivine Sagnier/Claire, Ludmilla Makowski/Claire, Soufiane Guerrab/Youssef Guedira, Clotilde Hesme/Juliette Pellegrini, Etan Simon/Raoul', 'Marcela Said'),
(last_insert_id(), 3, '2023-10-05', 'Omar Sy/Assane Diop, Shirine Boutella/Lieutenant Sofia Belkacem, Ludivine Sagnier/Claire, Ludmilla Makowski/Claire, Soufiane Guerrab/Youssef Guedira, Clotilde Hesme/Juliette Pellegrini, Etan Simon/Raoul', 'Marcela Said');
 
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
-- Lupin sezon 1
(last_insert_id(),1,1,'Chapter 1', 48),
(last_insert_id(),1,2,'Chapter 2', 53),
(last_insert_id(),1,3,'Chapter 3', 43),
(last_insert_id(),1,4,'Chapter 4 ', 41),
(last_insert_id(),1,5,'Chapter 5 ', 48),

-- Lupin sezon 2
(last_insert_id(),2,1,'Chapter 1', 43),
(last_insert_id(),2,2,'Chapter 2', 51),
(last_insert_id(),2,3,'Chapter 3', 50),
(last_insert_id(),2,4,'Chapter 4 ', 44),
(last_insert_id(),2,5,'Chapter 5 ', 50),

-- Lupin sezon 3
(last_insert_id(),3,1,'Chapter 1', 52),
(last_insert_id(),3,2,'Chapter 2', 48),
(last_insert_id(),3,3,'Chapter 3', 51),
(last_insert_id(),3,4,'Chapter 4 ', 43),
(last_insert_id(),3,5,'Chapter 5 ', 42),
(last_insert_id(),3,6,'Chapter 6 ', 42),
(last_insert_id(),3,7,'Chapter 7 ', 51);
            
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 6, 'The Haunting of the Hill House', 1,'2018-10-12');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1, '2018-10-12', 'Victoria Pedretti/Eleanor Crain Vance, Nell Crain, Kate Siegel/Theodora Crain, Henry Thomas/Hugh Crain, Oliver Jackson-Cohen/Luke Crain, Carla Gugino/Olivia Crain, Michiel Huisman/Steven Crain, Elizabeth Reaser/Shirley Crain Harris', 'Mike Flanagan');
			
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
-- The Haunting of the Hill House sezon 1
(last_insert_id(),1,1,'Steven sees a ghost', '60'),
(last_insert_id(),1,2,'Open Casket', '51'),
(last_insert_id(),1,3,'Touch', '53'),
(last_insert_id(),1,4,'The Twin Thing', '53'),
(last_insert_id(),1,5,'The Bent-Neck Lady', '70'),
(last_insert_id(),1,6,'Two Storms', '56'),
(last_insert_id(),1,7,'Eulogy', '63'),
(last_insert_id(),1,8,'Witness', '43'),
(last_insert_id(),1,9,'Screaming Meemies', '57'),
(last_insert_id(),1,10,'Silence Lay Steadily', '71');
            
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 1, 'WandaVision',1, '2021-01-15');
            
INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1, '2021-01-15', 'Elizabeth Olsen/Wanda Maximoff, Paul Bettany/Visio, Kathryn Hahn/Agnes, Teyonah Parris/Monica Rambea, Josh Stamberg/Director Hayward', 'Jac Schaeffer');
			
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
(last_insert_id(),1,1,'Filmed Before a Live Studio Audience', '31'),
(last_insert_id(),1,2,'Don`t Touch That Dial', '39'),
(last_insert_id(),1,3,'Now in Color', '35'),
(last_insert_id(),1,4,'We Interrupt This Program', '37'),
(last_insert_id(),1,5,'On a Very Special Episode', '43'),
(last_insert_id(),1,6,'All-New Halloween Spooktacular!', '40'),
(last_insert_id(),1,7,'Breaking the Fourth Wall', '39'),
(last_insert_id(),1,8,'Previously On', '48'),
(last_insert_id(),1,9,'The Series Finale', '51');


INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 5, 'The Summer I Turned Pretty',2, '2022-06-17');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
-- The Summer I Turned Pretty 2 sezoane 
(last_insert_id(), 1, '2022-06-17', 'Lola Tung/Belly, Christopher Briney/Conrad, Gavin Casalegno/Jeremiah, Sean Kaufman/Steven, Jackie Chung/Laurel, Rachel Blanchard/Susannah, Rain Spencer/Taylor', 'Zoe Cassavetes'),
(last_insert_id(), 2, '2023-07-14', 'Lola Tung/Belly, Christopher Briney/Conrad, Gavin Casalegno/Jeremiah, Sean Kaufman/Steven, Jackie Chung/Laurel, Rachel Blanchard/Susannah, Rain Spencer/Taylor', 'Zoe Cassavetes');
			
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
-- The Summer I Turned Pretty sezon 1
(last_insert_id(),1,1,'Summer House', '45'),
(last_insert_id(),1,2,'Summer Dress', '39'),
(last_insert_id(),1,3,'Summer Night', '41'),
(last_insert_id(),1,4,'Summer Heat', '42'),
(last_insert_id(),1,5,'Summer Catch', '39'),
(last_insert_id(),1,6,'Summer Tides', '41'),
(last_insert_id(),1,7,'Summer Love', '44'),

-- The Summer I Turned Pretty sezon 1
(last_insert_id(),2,1,'Love Lost', '44'),
(last_insert_id(),2,2,'Love Scene', '40'),
(last_insert_id(),2,3,'Love Sick', '43'),
(last_insert_id(),2,4,'Love Game', '42'),
(last_insert_id(),2,5,'Love Fool', '39'),
(last_insert_id(),2,6,'Love Fest', '41'),
(last_insert_id(),2,7,'Love Affair', '42'),
(last_insert_id(),2,8,'Love Triangle', '43');
            
            
INSERT INTO articol (tip) VALUES ('serial');
INSERT INTO seriale (id_articol, id_categorie, nume_serial, nr_sezoane, lansare_initiale) VALUES  
(last_insert_id(), 1, 'Agent Carter', 2, '2015-07-12');

INSERT INTO sezon (id_serial, nr_sezon, data_lansare, actori, regizor) VALUES 
(last_insert_id(), 1,' 2015-07-12 ', 'Hayley Atwell/Peggy Carter, James D`Arcy/Edwin Jarvis, Enver Gjokaj/Daniel Sousa, Chad Michael Murray/Jack Thompson, Wynn Everett/Whitney Frost, Reggie Austin/Jason Wilkes', 'Louis D`Esposito'),
(last_insert_id(), 2,' 2016-01-28 ', 'Hayley Atwell/Peggy Carter, James D`Arcy/Edwin Jarvis, Enver Gjokaj/Daniel Sousa, Chad Michael Murray/Jack Thompson, Wynn Everett/Whitney Frost, Reggie Austin/Jason Wilkes', 'Louis D`Esposito');
		
INSERT INTO episod (id_sezon,nr_sezon, nr_episod, nume, durata) VALUES 
-- Agent Carter sezon 1
(last_insert_id(),1,1,'Now is Not the End', '43'),
(last_insert_id(),1,2,'Bridge and Tunnel', '41'),
(last_insert_id(),1,3,'Time and Tide', '45'),
(last_insert_id(),1,4,'The Blitzkerieg Button', '40'),
(last_insert_id(),1,5,'The Iron Ceiling', '42'),
(last_insert_id(),1,6,'A Sin to Err', '41'),
(last_insert_id(),1,7,'SNAFU', '40'),
(last_insert_id(),1,8,'Valediction', '93'),

-- Agent Carter sezon 2
(last_insert_id(),2,1,'The Lady in The Lake', '43'),
(last_insert_id(),2,2,'A View in The Dark', '42'),
(last_insert_id(),2,3,'Better Angels', '41'),
(last_insert_id(),2,4,'Smoke & Mirrors', '40'),
(last_insert_id(),2,5,'The Atomic Job', '39'),
(last_insert_id(),2,6,'Life of the Party', '42'),
(last_insert_id(),2,7,'Monsters', '45'),
(last_insert_id(),2,8,'The Edge of Mystery', '41'),
(last_insert_id(),2,9,'A little Song and Dance', '42'),
(last_insert_id(),2,10,'Hollywood Ending','40');
            
     
SELECT * FROM articol;
SELECT * FROM film;
SELECT * FROM seriale;
SELECT * FROM sezon;
SELECT * FROM episod;

