import uvicorn

if __name__ == "__main__":
    uvicorn.run("back_end:app", port=5050, log_level="info", reload=True)
