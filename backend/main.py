from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

@app.get("/question")
def get_question():
    conn = psycopg2.connect(os.getenv("DATABASE_URL"))
    cur = conn.cursor()
    cur.execute("SELECT question, options, answer FROM questions ORDER BY RANDOM() LIMIT 1")
    row = cur.fetchone()
    conn.close()
    return {"question": row[0], "options": row[1], "answer": row[2]}
