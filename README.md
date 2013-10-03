
Blackjack Game
Assignment Due: Wednesday, October 02, 2013, 12:03 AM EST

Rules & Requirements:
Blackjack is a card game where you calculate the sum of the values of your cards and try to hit 21, aka "blackjack". Both the player and dealer are dealt two cards to start the game. All face cards are worth whatever numerical value they show. Suit cards are worth 10. Aces can be worth either 11 or 1. Example: if you have a Jack and an Ace, then you have hit "blackjack", as it adds up to 21.

After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay". Hitting means deal another card. If the player's cards sum up to be greater than 21, the player has "busted" and lost. If the sum is 21, then the player wins. If the sum is less than 21, then the player can choose to "hit" or "stay" again. If the player "hits", then repeat above, but if the player stays, then the player's total value is saved, and the turn moves to the dealer.

By rule, the dealer must hit until she has at least 17. If the dealer busts, then the player wins. If the dealer, hits 21, then the dealer wins. If, however, the dealer stays, then we compare the sums of the two hands between the player and dealer; higher value wins.

Hints:
1. Think of the data structure required to keep track of cards in a deck.
2. You'll need to look up and use a "while" loop, since there could be an indeterminate number of "hits" by both the player and dealer. "while" loops are used when we don't have a finite number of iterations.
3. Code something. Get started, even if it's just capturing the player's name. Give it an honest attempt before looking at solutions.
4. Use methods to extract the piece of functionality that calculates the total, since we need it throughout the program.

Bonus:
1. Save the player's name, and use it throughout the app.
2. Ask the player if he wants to play again, rather than just exiting.
3. Save not just the card value, but also the suit.
4. Use multiple decks to prevent against card counting players.
