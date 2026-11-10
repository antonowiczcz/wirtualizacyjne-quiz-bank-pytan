from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import psycopg2
import os

app = FastAPI()

def get_db():
    return psycopg2.connect(os.getenv("DATABASE_URL"))

class QuestionIn(BaseModel):
    question: str
    options: list[str]
    answer: str
    category_id: int

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/categories")
def get_categories():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, name FROM categories")
    rows = cur.fetchall()
    conn.close()
    return [{"id": row[0], "name": row[1]} for row in rows]

@app.get("/questions/{category_id}")
def get_questions(category_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id FROM categories WHERE id = %s", (category_id,))
    if not cur.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Nie ma takiej kategorii")
    cur.execute("SELECT id, question, options FROM questions WHERE category_id = %s", (category_id,))
    rows = cur.fetchall()
    conn.close()
    return [{"id": row[0], "question": row[1], "options": row[2]} for row in rows]

@app.get("/question/{category_id}")
def get_question(category_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id FROM categories WHERE id = %s", (category_id,))
    if not cur.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Nie ma takiej kategorii")
    cur.execute("SELECT id, question, options FROM questions WHERE category_id = %s ORDER BY RANDOM() LIMIT 1", (category_id,))
    row = cur.fetchone()
    conn.close()
    if not row:
        raise HTTPException(status_code=404, detail="Brak pytań w tej kategorii")
    return {"id": row[0], "question": row[1], "options": row[2]}

@app.get("/check/{question_id}/{answer}")
def check_answer(question_id: int, answer: str):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT answer FROM questions WHERE id = %s", (question_id,))
    row = cur.fetchone()
    conn.close()
    if not row:
        raise HTTPException(status_code=404, detail="Nie ma takiego pytania")
    return {"correct": row[0] == answer}

@app.post("/questions", status_code=201)
def add_question(q: QuestionIn):
    if not q.question.strip() or not q.answer.strip():
        raise HTTPException(status_code=400, detail="Pytanie i odpowiedź nie mogą być puste")
    if len(q.options) < 2:
        raise HTTPException(status_code=400, detail="Podaj co najmniej 2 opcje")
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id FROM categories WHERE id = %s", (q.category_id,))
    if not cur.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="Nie ma takiej kategorii")
    cur.execute(
        "INSERT INTO questions (question, options, answer, category_id) VALUES (%s, %s, %s, %s) RETURNING id",
        (q.question, q.options, q.answer, q.category_id)
    )
    new_id = cur.fetchone()[0]
    conn.commit()
    conn.close()
    return {"id": new_id, "question": q.question, "options": q.options, "answer": q.answer, "category_id": q.category_id}

@app.delete("/questions/{question_id}")
def delete_question(question_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("DELETE FROM questions WHERE id = %s RETURNING id", (question_id,))
    deleted = cur.fetchone()
    conn.commit()
    conn.close()
    if not deleted:
        raise HTTPException(status_code=404, detail="Nie ma takiego pytania")
    return {"deleted_id": question_id}
