# Magic the Gathering Booster Simulator
Booster generator that is used to simulate how many boosters are needed to obtain a certain collection of cards.

Boosters are generated using [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle).

Assumptions
+ Boosters do not have same card twice.
+ Cards of same rarity are equally likely to be in the booster.

Run the main.lua code using a Lua interpreter.
First eleven variables are used to configure the simulator.
