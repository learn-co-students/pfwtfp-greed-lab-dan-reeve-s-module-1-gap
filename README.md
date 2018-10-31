# Title

## Learning Goals

-SWBAT 1
-SWBAT 2

## Introduction

In some of our previous lessons, we worked on building the basics of a dice
throwing game. Now, it is time to put that code to use and implement a fully
functioning command line game, [Greed].

You are tasked with building the game logic using Ruby classes

## Rules of Greed

Greed requires at least 2 players and 6 six sided dice. Players take turns
rolling dice following a set of rules.

On a player's turn, the player starts by rolling all six dice.

- If the player does not roll a 1 or 5 or one of the special conditions, the
  player's turn ends.

  - Every 1 a player rolls is worth 100 points
  - Every 5 a player rolls is worth 50 points
  - Three of a kind for any number is worth that number times 100 in points
  - Four of a kind is worth the number times 100 x 2
  - Five of a kind is worth the number times 100 x 4
  - Six of a kind is worth the number times 100 x 8
  - Three of a kind for the number 1 is worth 1000 points
    - Four of a kind for 1 is worth 2000 points
    - Five of a kind for 1 is worth 4000 points
    - Six of a kind for 1 is worth 8000 points
  - Three pairs of numbers is worth 500 points
  - A five dice straight (1,2,3,4,5 or 2,3,4,5,6) is worth 1000 points
  - A six dice straight is worth 1500 points

If the player's dice roll meets any of the above criteria, they can choose to do
one of three things:

- The player can keep the score they got and add it to their total, ending
  their turn.

  > Player 1 rolls [1,3,5,3,3,1]: 200 points for two 1s, 50 points for 5, and 300 points for three 3s
  > Player 1 chooses to keep this score and end their turn, receiving 550 points

- The player can re-roll all six dice to try and get a better score, forfeiting
  any points they may have earned on the first roll

  > Player 2 rolls [3,2,6,2,2,6]: 200 points for three 2s
  > Player 2 chooses to roll all six dice again, forfeiting the 200 points
  > Player 2 rolls [5,2,2,2,1,5]: 100 points for one 1, 100 points for two 5s, 200 points for three 2s
  > Player 2 chooses to keep this score and end their turn, receiving 400 points

- The player can re-roll any amount of dice, setting aside particular dice.

  - Dice that are set aside cannot be used in combination with any newly
    rolled dice
  - If the player's re-roll does not result in any points, the turn ends and
    the player receives 0 points

  > Player 3 rolls [5,5,3,5,5,6]: 1000 points for four 5s
  > Player 3 chooses to keep the four 5s, but re-roll the remaining to dice
  > Player 3 rolls [3,1]: 100 points for one 1
  > Player 3 choose to keep the one 1 and re-roll the last die
  > Player 3 rolls [6]: 0 points
  > Player 3 does not receive any points from any of the three rolls and the turn ends

## Conclusion

## Resources

[greed]: http://thehobbyts.com/greed-dice-game-rules/
