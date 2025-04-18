from typing import Annotated
from fastapi import FastAPI, Query
from ..seventv_client import Client, EmoteSearchFilter, SearchEmotes

app = FastAPI(docs_url="/docs")
graphql_app = Client("https://7tv.io/v3/gql")

@app.get("/search-emotes")
async def search_emotes(
    query: Annotated[
            str,
            Query(
                title="Query string",
                description="Query string for the emotes to search in the 7tv"
            )
    ] = '',
    page: Annotated[
            int,
            Query(
                title="Page",
                description="Page number for paginated results (starting at 1)"
            )
    ] = 1,
    limit: Annotated[
            int,
            Query(
                title="Limit",
                description="Maximum number of emotes to return per page"
            )
    ] = 100,
    case_sensitive: Annotated[
            bool,
            Query(
                title="Case sensitive",
                description="If true, search is case-sensitive"
            )
    ] = False,
    exact_match: Annotated[
            bool,
            Query(
                title="Exact match",
                description="If true, only emotes exactly matching the query are returned"
            )
    ] = False,
) -> SearchEmotes:
    """
    Search for emotes in 7TV based on a query string and filters.

    Args:
        query: Search term for emotes.
        page: Page number for pagination.
        limit: Maximum number of emotes per page.
        case_sensitive: Enable case-sensitive search.
        exact_match: Require exact match for the query.

    Returns:
        SearchEmotes: A response containing the list of matching emotes and metadata.
    """
    return await graphql_app.search_emotes(
        query=query,
        page=page,
        limit=limit,
        filter=EmoteSearchFilter(
            case_sensitive=case_sensitive,
            exact_match=exact_match
        )
    )