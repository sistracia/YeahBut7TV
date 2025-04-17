import uvicorn
from .api import app

__all__ = [
    "app"
]

def main():
    uvicorn.run("back_end:app", host="0.0.0.0", port=5050, reload=True)