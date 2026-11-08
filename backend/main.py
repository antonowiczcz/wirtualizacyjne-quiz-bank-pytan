from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

def get_db():
    return psycopg2.connect(os.getenv("DATABASE_URL"))

@app.get("/categories")
def get_categories():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, name FROM categories")
    rows = cur.fetchall()
    conn.close()
    return [{"id": row[0], "name": row[1]} for row in rows]

@app.get("/question/{category_id}")
def get_question(category_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        "SELECT id, question, options FROM questions WHERE category_id = %s ORDER BY RANDOM() LIMIT 1",
        (category_id,)
    )
    row = cur.fetchone()
    conn.close()
    return {"id": row[0], "question": row[1], "options": row[2]}

@app.get("/check/{question_id}/{answer}")
def check_answer(question_id: int, answer: str):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT answer FROM questions WHERE id = %s", (question_id,))
    row = cur.fetchone()
    conn.close()
    return {"correct": row[0] == answer}
