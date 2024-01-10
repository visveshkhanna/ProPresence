from fastapi import FastAPI, File
from modules.facehandle import ProRecogntion
from time import time

app = FastAPI()

UPLOAD_FOLDER = "db/history"

# global object
propresence = ProRecogntion()

@app.post("/upload/")
async def upload_image(file: bytes = File(...)):

    filename = f"{UPLOAD_FOLDER}/T{int(time())}.jpg"

    with open(filename, "wb+") as buffer:
        buffer.write(file)
        buffer.close()

    return propresence.image(filename)
    

    
