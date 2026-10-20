import streamlit as st
import requests

st.title("Quiz")

if "pytanie" not in st.session_state:
    try:
        st.session_state.pytanie = requests.get("http://backend:8000/question", timeout=3).json()
    except:
        st.error("Brak połączenia z backendem")
        st.stop()

data = st.session_state.pytanie
wybor = st.radio(data["question"], data["options"])

if st.button("Sprawdź"):
    if wybor == data["answer"]:
        st.success("Dobrze!")
    else:
        st.error("Źle!")

if st.button("Następne pytanie"):
    del st.session_state["pytanie"]
    st.rerun()
