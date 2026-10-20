# Quizy i Bank Pytań

Projekt w ramach przedmiotu **Metody Wirtualizacji**  
Politechnika Poznańska, Cyberbezpieczeństwo 3 semestr

## 👥 Skład zespołu
* **Gracjan Antonowicz** (`@antonowiczcz`)
* **Michał Trojan** (`@michuu0`)

---

## 🚀 Uruchomienie projektu

### 1. Zmienne środowiskowe (.env)
Upewnij się, że w katalogu głównym projektu znajduje się plik `.env`:
```env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=secretpassword
POSTGRES_DB=mydb
DATABASE_URL=postgresql://postgres:secretpassword@db:5432/mydb
```

### 2. Start aplikacji
Uruchomienie wszystkich 3 kontenerów (baza danych, backend, frontend):
```bash
docker compose up --build
```

### 3. Dostęp w przeglądarce
* **Frontend (Streamlit):** [http://localhost:8501](http://localhost:8501)
* **Dokumentacja API (Swagger):** [http://localhost:8000/docs](http://localhost:8000/docs)
* **Endpoint API (losowe pytanie):** [http://localhost:8000/question](http://localhost:8000/question)

### 4. Zatrzymanie
```bash
docker compose down
```
*(Z czyszczeniem bazy danych: `docker compose down -v`)*

---

## 🏗️ Architektura kontenerów
1. **db** – PostgreSQL 15 (`db/Dockerfile`, inicjalizacja z `db/init.sql`).
2. **backend** – FastAPI (`backend/Dockerfile`, port `8000`).
3. **frontend** – Streamlit (`frontend/Dockerfile`, port `8501`).

---

<small>*Plik README został stworzony przy wsparciu sztucznej inteligencji.*</small>
