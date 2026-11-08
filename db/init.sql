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
('IT');

INSERT INTO questions (question, options, answer, category_id) VALUES
('Jaka jest stolica Polski?', ARRAY['Kraków', 'Warszawa', 'Gdańsk', 'Wrocław'], 'Warszawa', 1),
('Jaka jest stolica Francji?', ARRAY['Berlin', 'Madryt', 'Paryż', 'Rzym'], 'Paryż', 1),
('Ile to 2+2?', ARRAY['3', '4', '5', '6'], '4', 2),
('Ile to 3*3?', ARRAY['6', '8', '9', '12'], '9', 2),
('Jaki język używa się w tym projekcie?', ARRAY['Java', 'C++', 'Python', 'Ruby'], 'Python', 3),
('Co to jest Docker?', ARRAY['Edytor kodu', 'System wirtualizacji kontenerów', 'Baza danych', 'Framework webowy'], 'System wirtualizacji kontenerów', 3),
('Ile bajtów ma 1 kilobajt?', ARRAY['512', '1024', '2048', '256'], '1024', 3),
('Co to jest Docker Compose?', ARRAY['Narzędzie do definiowania i uruchamiania aplikacji wielokontenerowych', 'System plików w Linuksie', 'Kompilator języka Python', 'Edytor kodu'], 'Narzędzie do definiowania i uruchamiania aplikacji wielokontenerowych', 3),
('Czym jest atak SQL Injection?', ARRAY['Wstrzyknięciem złośliwego kodu SQL do zapytania aplikacji', 'Fizycznym uszkodzeniem serwera bazy danych', 'Atakiem DDoS', 'Błędem składni SQL'], 'Wstrzyknięciem złośliwego kodu SQL do zapytania aplikacji', 3);
