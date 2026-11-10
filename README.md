# Quizy i Bank Pytań

Projekt w ramach przedmiotu **Metody Wirtualizacji**  
Politechnika Poznańska, Cyberbezpieczeństwo 3 semestr

## 👥 Skład zespołu
* **Gracjan Antonowicz** (`@antonowiczcz`)
* **Michał Trojan** (`@michuu0`)

---

## 🚀 Uruchomienie projektu

### 1. Zmienne środowiskowe (.env)
Utwórz plik `.env` w katalogu głównym projektu:
```env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=secretpassword
POSTGRES_DB=mydb
DATABASE_URL=postgresql://postgres:secretpassword@db:5432/mydb
```

### 2. Start aplikacji
```bash
docker compose up --build
```

### 3. Dostęp w przeglądarce
* **Frontend (Streamlit):** http://localhost:8501
* **Dokumentacja API (Swagger):** http://localhost:8000/docs

### 4. Zatrzymanie
```bash
docker compose down
```

---

## 🏗️ Architektura kontenerów
1. **db** – PostgreSQL 15, inicjalizacja z `db/init.sql`, dane trwałe na wolumenie `pgdata`
2. **backend** – FastAPI, port `8000`
3. **frontend** – Streamlit, port `8501`

---

## 📡 API — endpointy

Wszystkie odpowiedzi są w formacie **JSON**.

---

### `GET /health`
Sprawdzenie czy serwer działa.

**Odpowiedź `200`:**
```json
{ "status": "ok" }
```

---

### `GET /categories`
Lista wszystkich kategorii pytań.

**Odpowiedź `200`:**
```json
[
  { "id": 1, "name": "Geografia" },
  { "id": 2, "name": "Matematyka" }
]
```

---

### `GET /questions/{category_id}`
Lista wszystkich pytań z danej kategorii.

**Parametr:** `category_id` – ID kategorii (liczba całkowita)

**Odpowiedź `200`:**
```json
[
  {
    "id": 1,
    "question": "Jaka jest stolica Polski?",
    "options": ["Kraków", "Warszawa", "Gdańsk", "Wrocław"]
  }
]
```

**Odpowiedź `404`** – kategoria nie istnieje:
```json
{ "detail": "Category not found" }
```

---

### `GET /question/{category_id}`
Losowe pojedyncze pytanie z danej kategorii.

**Parametr:** `category_id` – ID kategorii (liczba całkowita)

**Odpowiedź `200`:**
```json
{
  "id": 1,
  "question": "Jaka jest stolica Polski?",
  "options": ["Kraków", "Warszawa", "Gdańsk", "Wrocław"]
}
```

**Odpowiedź `404`** – kategoria nie istnieje lub brak pytań:
```json
{ "detail": "Category not found" }
```

---

### `GET /check/{question_id}/{answer}`
Sprawdzenie czy odpowiedź jest poprawna.

**Parametry:** `question_id` – ID pytania, `answer` – udzielona odpowiedź

**Odpowiedź `200`:**
```json
{ "correct": true }
```

**Odpowiedź `404`** – pytanie nie istnieje:
```json
{ "detail": "Question not found" }
```

---

### `POST /questions`
Dodanie nowego pytania.

**Body (JSON):**
```json
{
  "question": "Jaka jest stolica Niemiec?",
  "options": ["Berlin", "Monachium", "Hamburg", "Kolonia"],
  "answer": "Berlin",
  "category_id": 1
}
```

**Odpowiedź `201`:**
```json
{
  "id": 21,
  "question": "Jaka jest stolica Niemiec?",
  "options": ["Berlin", "Monachium", "Hamburg", "Kolonia"],
  "answer": "Berlin",
  "category_id": 1
}
```

**Odpowiedź `400`** – błędne dane (puste pola, za mało opcji):
```json
{ "detail": "..." }
```

**Odpowiedź `404`** – kategoria nie istnieje:
```json
{ "detail": "Category not found" }
```

---

### `DELETE /questions/{question_id}`
Usunięcie pytania po ID.

**Parametr:** `question_id` – ID pytania (liczba całkowita)

**Odpowiedź `200`:**
```json
{ "deleted_id": 21 }
```

**Odpowiedź `404`** – pytanie nie istnieje:
```json
{ "detail": "Question not found" }
```

---

<small>*Plik README został stworzony przy wsparciu sztucznej inteligencji.*</small>
