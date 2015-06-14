So it's not really a multiplayer game in that users won't compete with each other, but it should support multiple games simultaneously. In this challenge you'll build an application that uses HTTP cookies to maintain the state of a game between multiple HTTP requests.

### Instructions

Build a web-based version of Rock, Paper, Scissors where the user competes against a computer AI. The game should meet the following requirements:

* Upon first visit of the app the user starts a new game against a computer opponent.
* The user can choose one of three options (rock, paper, or scissors) by submitting an HTML form.
* When the user submits their choice, the computer AI randomly chooses one of the three options and the winner receives a point. If there is a tie there is no point awarded.
* When a user submits their choice, refreshing the page should not re-submit that choice again (use the [Post/Redirect/Get pattern](http://en.wikipedia.org/wiki/Post/Redirect/Get) to avoid this scenario).
* The first player to win [best-of-three](http://en.wikipedia.org/wiki/Playoff_format#Best-of_formats) is declared the winner.
* Once the game has been won, the user has an option to restart the game.
* The app should be able to support multiple games simultaneously. This can be tested by visiting the page in multiple browsers or private browsing sessions to ensure they are using different sessions.
* No JavaScript should be used.
* No game state should be persisted on the server (i.e. no databases or files should be used).

### Tips

Consider what information you need to maintain the state of the game. Do you need to remember every action that was taken, or is it sufficient to use just the scores?

If using the [Post/Redirect/Get pattern](http://en.wikipedia.org/wiki/Post/Redirect/Get) you'll often need to pass messages along with a redirect (e.g. notifying a user what happened this round). These are called **flash messages** and are implemented using the session to store a temporary message that is wiped out after one request.

Everything that is stored in the session is encoded as a string. If storing numeric values, remember to convert them back to integers when reading from the session (using the `to_i` method).
