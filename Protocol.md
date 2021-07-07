# App -> TV

## search

Request:

```json
{
  "name": "search",
  "uuid": "uuid",
  "query": "Whatever query"
}
```

Response:

```json
{
    "uuid": "uuid",
    "query": [
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
}
```

## upvote

Request:

```json
{
    "name": "upvote",
    "uuid": "uuid",
    "id": "song-id"
}
```

Response:

```json
{
    "uuid": "uuid"
}
```

## downvote

Request:

```json
{
    "name": "downvote",
    "uuid": "uuid",
    "id": "song-id"
}
```

Response:

```json
{
    "uuid": "uuid"
}
```

## addQueue

Request:

```json
{
    "name": "addQueue",
    "uuid": "uuid",
    "id": "song-id"
}
```

Response:

```json
{
    "uuid": "uuid"
}
```

# TV -> App

## queueUpdate

Request:

```json
{
    "name": "queueUpdate",
    "uuid": "uuid",
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
{
    "uuid": "uuid"
}
```

## currentlyPlaying

Request:

```json
{
    "name": "currentlyPlaying",
    "uuid": "uuid",
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
{
    "uuid": "uuid"
}
```

## pause

Request:

```json
{
    "name": "pause",
    "uuid": "uuid",
    "time": 10
}
```

Response:

```json
{
    "uuid": "uuid"
}
```

## play

Request:

```json
{
    "name": "play",
    "uuid": "uuid",
    "time": 10
}
```

Response:

```json
{
  "uuid": "uuid"
}
```