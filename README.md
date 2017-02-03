# Rails Flashcards Server

A Rails backend for a simple flashcards app. A user may: 
- Register, log in, log out
- Create, update delete flashcards
- Create, update and decks for the cards.
- Add or remove cards from decks.

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

## Endpoint Status 

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

