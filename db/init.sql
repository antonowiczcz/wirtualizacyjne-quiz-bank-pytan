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
('Ile bajtów ma 1 kilobajt?', ARRAY['512', '1024', '2048', '256'], '1024'),
('Co to jest Docker?', ARRAY['Edytor kodu', 'System wirtualizacji na poziomie systemu operacyjnego (konteneryzacja)', 'Baza danych NoSQL', 'Framework webowy'], 'System wirtualizacji na poziomie systemu operacyjnego (konteneryzacja)'),
('Czym różni się kontener od maszyny wirtualnej (VM)?', ARRAY['Kontenery dzielą jądro systemu operacyjnego hosta', 'Kontenery wymagają pełnego hipernadzorcy (Hypervisor typu 1)', 'Maszyny wirtualne nie potrzebują systemu gościa (Guest OS)', 'Nie ma między nimi żadnej różnicy'], 'Kontenery dzielą jądro systemu operacyjnego hosta'),
('Co to jest Docker Compose?', ARRAY['Narzędzie do definiowania i uruchamiania aplikacji wielokontenerowych', 'System plików w Linuksie', 'Kompilator języka Python', 'Klient bazy PostgreSQL'], 'Narzędzie do definiowania i uruchamiania aplikacji wielokontenerowych'),
('Czym jest atak typu SQL Injection?', ARRAY['Wstrzyknięciem złośliwego kodu SQL do zapytania aplikacji', 'Fizycznym uszkodzeniem serwera bazy danych', 'Atakiem DDoS na łącze sieciowe', 'Podsłuchiwaniem nieszyfrowanego hasła'], 'Wstrzyknięciem złośliwego kodu SQL do zapytania aplikacji');

-- przy tworzeniu części pytań wykorzystano pomoc si