# Rails Flashcards Server

A Rails backend for a simple [flashcards](https://en.wikipedia.org/wiki/Flashcard) app. Might be comercialized.

## Status

### Currently

As of 2017/02/03, the backend allows a client to: 

- Register, log in, log out.
- See, create, update, delete a user's flashcards.
- See, create, update delete a user's decks of cards.
- Add or remove cards from decks.

### Future

Features I'd like to implement, roughly sorted by priority:

- Update a user's password and email.
- Support allowing users to test themselves on decks:
    - Potential methods are:
        - By going through every card.
        - By quizzing through multiple choice questions generated from a deck.
    - Provide endponts to:
        - Start and finish tests.
        - Get past test results for decks and individual cards.
        - Provide statistics/info for spaced repetition.
- Support images and audio on cards.
    - Size/cuantity limitations?
- Limit access to features to user categories.
- Store a user's custom display name for social functions (unique? proper name or username?)
- Store a user's custom image for social functions.
- Social functions:
    - Sharing between users:
        - From user to user?
        - Allow users to make decks/cards public?
        - Via "friends"
    - "Stream" or "feed" view?
        - Show past test results.
        - Show friends activity
        - Show interesting decks

Non-features:

- Tests
- Proper documentation
- Deployment/CI: 
    - Move hardcoded keys and envvars out.
    - Test and production servers.
    - Continuous integration stuff.

See roadmap secion below for an overview of how I'm thinking of adding stuff. 

## Models

### Card 

A `Card` is a flashcard a user made, it may "belong" to any number of `Deck`s.

Attrib | Type | Descr | Nullable? | User-provided?
--- | --- | --- | --- | ---
`id` | `int` | Card's ID | x | x
`user` | `int` | Card's owner's ID | x | x
`title_front` | `string` | Card's title text on front side | ✔ | ✔
`descr_front` | `string` | Card's description text on front side | ✔ | ✔
`title_back` | `string` | Card's title text on back side | ✔ | ✔
`descr_back` | `string` | Card's description text on back side | ✔ | ✔
`deck_count` | `int` | Number of decks this card belongs to | x | x

### Deck 

A `Deck` is a collecion of flashcards. It may "contain" any number of `Card`s.
 
Attrib | Type | Descr | Nullable? | User-provided?
--- | --- | --- | --- | ---
`id` | `int` | Decks's ID | x | x
`user` | `int` | Decks's owner's ID | x | x
`title` | `string` | Title of the deck | ✔ | ✔
`descr` | `string` | Description of the deck | ✔ | ✔
`color` | `string` | Color of the deck | ✔ | ✔
`card_count` | `int` | Number of cards this deck has | x | x

### DeckCard

An association between a `Deck` and a `Card`. Create or delete these to "add" or "remove"  flashcards to decks.

Attrib | Type | Descr | Nullable? | User-provided?
--- | --- | --- | --- | ---
`id` | `int` | DeckCard's ID | x | x
`user` | `int` | DeckCards's owner's ID | x | x
`deck` | `int` | Associated deck's ID | x | ✔
`card` | `int` | Associated card's ID | x | ✔

### Other Models (pending documentation)

- User
- Session

## Endpoints 

Method | Endpoint | Descr | Implemented | Auth? | Tests
--- | --- | --- | --- | --- | ---
 **User** | 
POST | `v1/register` | Registers a user, returns user object | ✔ |
POST | `v1/login` | Logs a user in, returns user object and token | ✔ |
POST | `v1/logout` | Logs a user out (wipes token), returns only 200 if OK | ✔ | ✔ |
 **Card** | 
GET | `v1/cards` | Returns all cards for user | ✔ | ✔ |
POST | `v1/cards` | Creates a card, returns card with ID | ✔ | ✔ |
GET | `v1/cards/:id` | Returns a card with provided ID | ✔ | ✔ |
PUT | `v1/cards/:id` | Updates attrs for card with provided ID, returns card with ID | ✔ | ✔ |
DELETE | `v1/cards/:id` | Deletes card with provided ID | ✔ | ✔ |
 **Deck** | 
GET | `v1/decks` | Returns all decks for user | ✔ | ✔ |
POST | `v1/decks` | Creates a deck, returns deck with ID | ✔ | ✔ |
GET | `v1/decks/:id` | Returns a deck with provided ID | ✔ | ✔ |
PUT | `v1/decks/:id` | Updates attrs for deck with provided ID, returns deck with ID | ✔ | ✔ |
DELETE | `v1/decks/:id` | Deletes deck with provided ID | ✔ | ✔ |
 **DeckCard** | 
GET | `v1/deckcards` | Returns all deckcards for user | ✔ | ✔ |
POST | `v1/deckcards` | Creates a deckcard, returns deckcard with ID | ✔ | ✔ |
GET | `v1/deckcards/:id` | Returns a deckcard with provided ID | ✔ | ✔ |
DELETE | `v1/deckcards/:id` | Deletes deckcard with provided ID | ✔ | ✔ |

## Roadmap

### Test model + endpoints

A user will be able to test himself by going through a deck (testing each flashcard) or by doing a 
multiple-choice quiz on a deck.

Contains: 
- A user's ID
- A deck's ID
- Whether it's a "deck-test" or a "quiz-test"
- Whether the test is completed
- Start time
- Completion time

### Test rating + endpoints

A test rating is the result of a test, could potentially be integrated into the test model.

Contains:
- Referenced test's ID
- Failed questions count (all q's)
- Passed questions count (all q's)
- Hard passed q's count (passed with difficulty)
- Medium passed q's count (passed with medium difficulty)
- Easy passes q's count (passed easily)
- Skipped questions count (number of questions that were skipped)

### Card rating + endpoints

An individual rating for a card. People will test themselves on cards any times. This intends to 
track a user's attempts to answer a card.

Contains:
- Referenced card's ID
- Rating result (failed/passed/passed with a specific difficulty/skipped)

### AppStart model + endpoints

An object submitted to server every time the user starts the app. Point of this is to get 
some basic analytics while also registering for push notifications. Only one (latest) instance
per user.

Contains: 
- A user's ID
- Token they logged in with
- Push token for iOS or Android (or nil if notifications are disabled)
- App version, OS (iOS/Android), OS version, device maker and model.

