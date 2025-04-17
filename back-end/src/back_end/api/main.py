from fastapi import FastAPI
from ..seventv_client import Client
from .types import RootResponse

app = FastAPI(docs_url="/docs")

graphql_app = Client("https://7tv.io/v3/gql")

@app.get("/")
async def root() -> RootResponse:
    response = await graphql_app.search_emotes(query="FeelsStrongMan")
    print(response)
    return RootResponse(hello="world")