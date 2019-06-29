Stockfish Polyglot 2019-06-29

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: Timestamp: 1561621596 - Bonus for double attacks on unsupported pawns.

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

--------------------------------------

Due to the missing of this feature in the main release I have decided
to create a Stockfish perfectly equal to the last beta version with
the capability to use Polyglot books (aka .bin or BIN).
In order to do that I used the library polyblook.h from Brainfish and
merged with the Stockfish code.

--------------------------------------

Stockfish Polyglot 2019-06-29

Changes since the last Stockfish Polyglot release:

Author: protonspring 
Date: Thu Jun 27 09:46:36 2019 +0200 
Timestamp: 1561621596 

Bonus for double attacks on unsupported pawns 

This is a functional change that rewards double attacks on an unsupported pawns. 

STC (non-functional difference) 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 83276 W: 18981 L: 18398 D: 45897 Elo +2.43
http://tests.stockfishchess.org/tests/view/5d0970500ebc5925cf0a77d4 

LTC (incomplete looping version) 
LLR: 0.50 (-2.94,2.94) [0.00,3.50] 
Total: 82999 W: 14244 L: 13978 D: 54777 Elo +1.11
http://tests.stockfishchess.org/tests/view/5d0a8d480ebc5925cf0a8d58 

LTC (completed non-looping version). 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 223381 W: 38323 L: 37512 D: 147546 Elo +1.26
http://tests.stockfishchess.org/tests/view/5d0e80510ebc5925cf0ad320 

Closes https://github.com/official-stockfish/Stockfish/pull/2205 

Bench 3633546 

---------------------------------- 

Comments by Alain SAVARD: 

interesting result ! I would have expected that search would resolve such positions 
correctly on the very next move. This is not a very common pattern, and when it happens, 
it will quickly disappear. So I'm quite surprised that it passed LTC. 
I would be even more surprised if this would resist a simplification. 

Anyway, let's try to imagine a few cases. 

a) If you have White d5 f5 against Black e6, and White to move 
last move by Black was probably a capture on e6 and White is about to recapture on e6 

b) If you have White d5 f5 against e6, and Black to move 
last move by White was possibly a capture on d5 or f5 
or the pawn on e6 was pinned or could not move for some reason. 
and white wants to blast open the position and just pushed d4-d5 or f4-f5 

Some possible follow-ups 
a) Motif is so rare that the popcount() can be safely replaced with a bool() 
But this would not pass a SPRT[0,4], 
So try a simplification with bool() and also without the & ~theirAttacks 

b) If it works, we probably can simply have this in the loop 
if (lever) score += S(0, 20); 

c) remove all this and tweak something in search for pawn captures (priority, SEE, extension,..) 
 
Author: Vizvezdenec 
Date: Thu Jun 27 09:26:08 2019 +0200 
Timestamp: 1561620368 

Introduce attacks on space area 

This patch introduces a small malus for every square in our space mask 
that is attacked by enemy. The value of the malus is completely arbitrary 
and is something we can tweak, also maybe we can gain some elo with tweaking 
space threshold after this addition. 

Passed STC 
http://tests.stockfishchess.org/tests/view/5d10ce590ebc5925cf0af30b 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 7082 W: 1648 L: 1449 D: 3985 Elo +9.77

Passed LTC 
http://tests.stockfishchess.org/tests/view/5d10d2d80ebc5925cf0af3fd 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 79494 W: 13727 L: 13324 D: 52443 Elo +1.76

Closes https://github.com/official-stockfish/Stockfish/pull/2207 

bench 3516460 
 
Author: Sergei Ivanov 
Date: Thu Jun 27 09:05:03 2019 +0200 
Timestamp: 1561619103 

Do not define increment operators on Value, Depth and Direction 

These operators are never used and do not make sense for these types. 

No functional change. 
 
Author: joergoster 
Date: Thu Jun 27 08:57:59 2019 +0200 
Timestamp: 1561618679 

Improve multiPV mode 

Skip all moves during the Non-PV (zero-window) search which will be 
searched as PV moves later anyways. We also wake sure the moves will 
be reported to the GUI despite they're not being searched — some GUIs 
may get confused otherwise, and it would unnecessarily complicate the 
code. 

Tested with MultiPV=4 
STC 
http://tests.stockfishchess.org/tests/view/5ce7137c0ebc5925cf070d69 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 8233 W: 3708 L: 3424 D: 1101 Elo +11.99

LTC 
http://tests.stockfishchess.org/tests/view/5ce798d60ebc5925cf071d17 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 7369 W: 3197 L: 2911 D: 1261 Elo +13.49

Closes https://github.com/official-stockfish/Stockfish/pull/2163 

No functional change. (in single PV mode) 
 
Author: Joost VandeVondele 
Date: Sat Jun 22 09:57:07 2019 +0200 
Timestamp: 1561190227 

Make the debug counters thread safe. 

needed to use them in a threaded run. 

No functional change. 
 
Author: Vizvezdenec 
Date: Fri Jun 21 10:05:50 2019 +0200 
Timestamp: 1561104350 

Rewrite "More bonus for free passed pawn" 

-removes wideUnsafeSquares bitboard 
-removes a couple of bitboard operations 
-removes one if operator 
-updates comments so they actually represent what this part of code is doing now. 

passed non-regression STC 
http://tests.stockfishchess.org/tests/view/5d0c1ae50ebc5925cf0aa8db 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 16892 W: 3865 L: 3733 D: 9294 Elo +2.72

No functional change