# App -> TV

## search

Request:

```json
{
    "name": "search"
    "query": "Whatever query"
}
```

Response:

```json
[
    {
        "id": "0nbXyq5TXYPCO7pr3N8S4I",
        "name": "The Box",
        "album": "Please Excuse Me for Being Antisocial",
        "artists": ["Roddy Ricch"],
        "inQueue": false,
        "length": 196,
        "imageUrl": "https://i.scdn.co/image/ab67616d0000b273600adbc750285ea1a8da249f",
        "upvotes": 0,
        "downvotes": 0
    }
]
```

## upvote

Request:

```json
{
    "name": "upvote"
    "id": "song-id"
}
```

Response:

```json
{}
```

## downvote

Request:

```json
{
    "name": "downvote",
    "id": "song-id"
}
```

Response:

```json

```

## addQueue

Request:

```json
{
    "name": "addQueue",
    "id": "song-id"
}
```

Response:

```json
{}
```

# TV -> App

## queueUpdate

Request:

```json
{
    "name": "queueUpdate",
    "queue": [
        {
        	"id": "0nbXyq5TXYPCO7pr3N8S4I",
        	"name": "The Box",
        	"album": "Please Excuse Me for Being Antisocial",
        	"artists": ["Roddy Ricch"],
        	"inQueue": false,
        	"length": 196,
        	"imageUrl": "https://i.scdn.co/image/ab67616d0000b273600adbc750285ea1a8da249f",
        	"upvotes": 0,
        	"downvotes": 0
    	},
        // ...
    ]
}
```

Response:

```json
{}
```

## currentlyPlaying

Request:

```json
{
    "name": "currentlyPlaying",
    "song": {
        "id": "0nbXyq5TXYPCO7pr3N8S4I",
        "name": "The Box",
        "album": "Please Excuse Me for Being Antisocial",
        "artists": ["Roddy Ricch"],
        "inQueue": false,
        "length": 196,
        "imageUrl": "https://i.scdn.co/image/ab67616d0000b273600adbc750285ea1a8da249f",
        "upvotes": 0,
        "downvotes": 0
    }
}
```

Response:

```json
{}
```

## pause

Request:

```json
{
    "name": "pause",
    "time": 10 // The time (in seconds) paused at
}
```

Response:

```json
{}
```

## play

Request:

```json
{
    "name": "play",
    "time": 10 // The time (in seconds) to play the song from
}
```

Response:

```json
{}
```