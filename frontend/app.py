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
            st.rerun()
    st.stop()


if "pytanie" not in st.session_state:
    res = requests.get(f"{BACKEND}/question/{st.session_state.kategoria}", timeout=3)
    st.session_state.pytanie = res.json()

data = st.session_state.pytanie
wybor = st.radio(data["question"], data["options"])

if st.button("Sprawdź"):
    res = requests.get(f"{BACKEND}/check/{data['id']}/{wybor}", timeout=3).json()
    if res["correct"]:
        st.success("Dobrze!")
    else:
        st.error("Źle!")

col1, col2 = st.columns(2)
with col1:
    if st.button("Następne pytanie"):
        del st.session_state["pytanie"]
        st.rerun()
with col2:
    if st.button("Zmień kategorię"):
        del st.session_state["pytanie"]
        del st.session_state["kategoria"]
        st.rerun()
