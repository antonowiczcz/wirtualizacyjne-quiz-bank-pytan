CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    question TEXT,
    options TEXT[],
    answer TEXT,
    category_id INTEGER REFERENCES categories(id)
);

INSERT INTO categories (name) VALUES
('Geografia'),
('Matematyka'),
('IT'),
('Historia'),
('Biologia');

INSERT INTO questions (question, options, answer, category_id) VALUES
-- Geografia
('Jaka jest stolica Polski?', ARRAY['Kraków', 'Warszawa', 'Gdańsk', 'Wrocław'], 'Warszawa', 1),
('Jaka jest stolica Francji?', ARRAY['Berlin', 'Madryt', 'Paryż', 'Rzym'], 'Paryż', 1),
('Jaki jest największy ocean na Ziemi?', ARRAY['Spokojny', 'Atlantycki', 'Indyjski', 'Arktyczny'], 'Spokojny', 1),
('Na jakim kontynencie leży Polska?', ARRAY['Azja', 'Afryka', 'Europa', 'Ameryka Północna'], 'Europa', 1),

-- Matematyka
('Ile to 2+2?', ARRAY['3', '4', '5', '6'], '4', 2),
('Ile to 3*3?', ARRAY['6', '8', '9', '12'], '9', 2),
('Ile boków ma trójkąt?', ARRAY['2', '3', '4', '5'], '3', 2),
('Ile to 10 - 4?', ARRAY['5', '6', '7', '8'], '6', 2),

-- IT
('Co to jest Docker?', ARRAY['Edytor kodu', 'System wirtualizacji kontenerów', 'Baza danych', 'Framework webowy'], 'System wirtualizacji kontenerów', 3),
('Jaki język używa się w tym projekcie?', ARRAY['Java', 'C++', 'Python', 'Ruby'], 'Python', 3),
('Ile bajtów ma 1 kilobajt?', ARRAY['512', '1024', '2048', '256'], '1024', 3),
('Co to jest Docker Compose?', ARRAY['Narzędzie do definiowania i uruchamiania aplikacji wielokontenerowych', 'System plików w Linuksie', 'Kompilator języka Python', 'Edytor kodu'], 'Narzędzie do definiowania i uruchamiania aplikacji wielokontenerowych', 3),

-- Historia
('W którym roku wybuchła II wojna światowa?', ARRAY['1914', '1939', '1945', '1918'], '1939', 4),
('Kto był pierwszym koronowanym królem Polski?', ARRAY['Mieszko I', 'Bolesław Chrobry', 'Kazimierz Wielki', 'Władysław Jagiełło'], 'Bolesław Chrobry', 4),
('W którym roku odbył się chrzest Polski?', ARRAY['966', '1000', '1410', '1791'], '966', 4),
('Kto odkrył Amerykę w 1492 roku?', ARRAY['Krzysztof Kolumb', 'Ferdynand Magellan', 'Vasco da Gama', 'James Cook'], 'Krzysztof Kolumb', 4),

-- Biologia
('Jaki gaz jest niezbędny ludziom do oddychania?', ARRAY['Tlen', 'Azot', 'Wodór', 'Hel'], 'Tlen', 5),
('Co produkują pszczoły?', ARRAY['Mleko', 'Miód', 'Oliwę', 'Cukier'], 'Miód', 5),
('Które zwierzę jest największym ssakiem na Ziemi?', ARRAY['Słoń afrykański', 'Płetwal błękitny', 'Żyrafa', 'Rekin wielorybi'], 'Płetwal błękitny', 5),
('Który narząd człowieka odpowiada za pompowanie krwi?', ARRAY['Mózg', 'Żołądek', 'Serce', 'Płuca'], 'Serce', 5);

-- wykorzystano si do wygenerowania części kodu
