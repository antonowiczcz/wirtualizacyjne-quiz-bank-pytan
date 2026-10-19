CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    question TEXT,
    options TEXT[],
    answer TEXT
);

INSERT INTO questions (question, options, answer) VALUES
('Jaka jest stolica Polski?', ARRAY['Kraków', 'Warszawa', 'Gdańsk', 'Wrocław'], 'Warszawa'),
('Ile to 2+2?', ARRAY['3', '4', '5', '6'], '4'),
('Jaki język używa się w tym projekcie?', ARRAY['Java', 'C++', 'Python', 'Ruby'], 'Python'),
('Co to jest Docker?', ARRAY['Edytor kodu', 'System wirtualizacji kontenerów', 'Baza danych', 'Framework webowy'], 'System wirtualizacji kontenerów'),
('Ile bajtów ma 1 kilobajt?', ARRAY['512', '1024', '2048', '256'], '1024');
