import streamlit as st
import requests

BACKEND = "http://backend:8000"

st.title("Quiz")


if "kategoria" not in st.session_state:
    st.subheader("Wybierz kategorię:")
    categories = requests.get(f"{BACKEND}/categories", timeout=3).json()
    for cat in categories:
        if st.button(cat["name"]):
            st.session_state.kategoria = cat["id"]
            st.session_state.pytania = requests.get(f"{BACKEND}/questions/{cat['id']}", timeout=3).json()
            st.session_state.indeks = 0
            st.rerun()
    st.stop()


if "pytania" not in st.session_state or "indeks" not in st.session_state:
    st.session_state.pytania = requests.get(f"{BACKEND}/questions/{st.session_state.kategoria}", timeout=3).json()
    st.session_state.indeks = 0

if st.session_state.indeks >= len(st.session_state.pytania):
    st.success("Odpowiedziałeś na wszystkie pytania z tej kategorii!")
    if st.button("Wybierz inną kategorię"):
        del st.session_state["kategoria"]
        del st.session_state["pytania"]
        del st.session_state["indeks"]
        st.rerun()
    st.stop()

data = st.session_state.pytania[st.session_state.indeks]
wybor = st.radio(data["question"], data["options"], key=f"q_{data['id']}")

if st.button("Sprawdź"):
    res = requests.get(f"{BACKEND}/check/{data['id']}/{wybor}", timeout=3).json()
    if res["correct"]:
        st.success("Dobrze!")
    else:
        st.error("Źle!")

col1, col2 = st.columns(2)
with col1:
    if st.button("Następne pytanie"):
        st.session_state.indeks += 1
        st.rerun()
with col2:
    if st.button("Zmień kategorię"):
        del st.session_state["kategoria"]
        del st.session_state["pytania"]
        del st.session_state["indeks"]
        st.rerun()

# wykorzystano si do wygenerowania części kodu