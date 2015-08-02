# AttaCard-Generator
A generator for a possible future card game or two.

# Concept

When I saw an article on [Squib](https://andymeneely.github.io/squib/), a few very old ideas came up that I could see using the library for.  Figuring they might make good tests, I decided to spend a day brushing one or two of them off to see if Squib could cope with my imagination.

My final idea became a deck of cards that could be used for both a kind of war/combat game to capture card and a basic storytelling game.  I added the idea that each card would have two suits, as much a test for Squib as a possible way to make games more interesting.

And, because a project should be automated, it should be at least _possible_ to generate most of the deck programmatically.

# The Cards

The eventual goal is to have a tarot-like deck, with a total of seventy-eight (78) cards, with four suits of numbered cards and twenty-two (22) named "arcana" cards, albeit with a twist or two along the way.

__Note__:  At this time, the suited cards are generated randomly through the `gencards.sh` script, at least numerically.  Because these are the only cards finalized, `deck.rb` only lays those out.  Watch this space!  (Or don't.)

The card information is stored in `cards.csv`, though only a limited amount of information gets generated.

## Pseudo-Suits

There are four "suits" in the deck, but each card carries _two_ suits with independent values.  In the intended games, those suits are intended to abstractly (and almost certainly inaccurately) represent parts of a single attack in combat.

 - _Aim_ refers to the ability of a player's hand to land an attack on an opponent.

 - _Force_ refers to the strength of that attack.

 - _Evade_ is the opposite of _Aim_, the ability to avoid an attack.

 - _Defend_ is the opposite of _Force_, the ability to resist an attack.

Information for the suits, like the names and "visual identity," are stored in `dynamic.csv`.

## Arcana

TBD

## Generating Cards

As mentioned, the `gencards.sh` bash script generates a random deck of pseudo-suited cards.  It reads the suit names from `dynamic.csv` and uses some interesting-but-not-quite-sufficiently clever filters to pair off random values of different suits.

# Credits
[Squib](https://andymeneely.github.io/squib/) was created by [Andy Meneely](https://github.com/andymeneely) and made available under the [MIT License](https://github.com/andymeneely/squib/blob/master/LICENSE.txt).

Icons made by [Lorc](http://lorcblog.blogspot.com), available under a [Creative Commons Attribution 3.0 Licence](https://creativecommons.org/licenses/by/3.0/).  Most of them have been manually modified for contrast, and I claim no rights over that trivial change.

