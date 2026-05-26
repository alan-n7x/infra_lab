import logging, os
from fastapi import FastAPI

os.makedirs("logs", exist_ok=True)

logging.basicConfig(
    filename=os.path.join("logs", "app.log"),
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)

app = FastAPI()


@app.get("/")
def home():

    logging.info(f"Rota: /")
    return {"message": "Hello World"}


@app.get("/status")
def status():
    logging.info("Rota: Status")
    return {"status": "online"}
