Stockfish Polyglot 2019-09-12

This distribution is the expansion of Stockfish beta having timestamp: 1568277198 - Scale down complexity for almost unwinnable endgames.

Due to the missing of this feature in the main release I have decided
to create a Stockfish perfectly equal to the last beta version with
the capability to use Polyglot books (aka .bin or BIN).
In order to do that I used the library polyblook.h from Brainfish and
merged with the Stockfish code.

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

--------------------------------------

Changes since the last version:

Author: Vizvezdenec 
Date: Thu Sep 12 10:33:18 2019 +0200 
Timestamp: 1568277198 

Scale down complexity for almost unwinnable endgames 

This patch greatly scales down complexity of endgames when the 
following conditions are all true together: 

- pawns are all on one flank 
- stronger side king is not outflanking weaker side 
- no passed pawns are present 

This should improve stockfish evaluation of obvious draws 4 vs 3, 3 vs 2 
and 2 vs 1 pawns in rook/queen/knight/bishop single flank endgames where 
strong side can not make progress. 

passed STC 
LLR: 2.94 (-2.94,2.94) [0.50,4.50] 
Total: 15843 W: 3601 L: 3359 D: 8883 Elo +5.31

passed LTC 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 121275 W: 20107 L: 19597 D: 81571 Elo +1.46

Closes https://github.com/official-stockfish/Stockfish/pull/2298 

Bench: 3954190 

========================== 

How to continue from there? 

a) This could be a powerful idea for refining some parts of the evaluation 
 function, a bit like when we try quadratics or other equations to emphasize 
 certain situations (xoto10). 

b) Some other combinaison values for this bonus can be done further, or 
 overall retuning of weight and offset while keeping the formula simple. 
 
Author: xoto10 
Date: Thu Sep 12 10:05:35 2019 +0200 
Timestamp: 1568275535 

Bonus for rook on same file as their queen 

This patch creates a simple bonus for a rook that is on the same file as the 
opponent's queen. 

STC 10+0.1 th 1 : 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 45609 W: 10120 L: 9733 D: 25756 Elo +2.95
http://tests.stockfishchess.org/tests/view/5d79895a0ebc5902d385484a 

LTC 60+0.6 th 1 : 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 51651 W: 8606 L: 8288 D: 34757 Elo +2.14
http://tests.stockfishchess.org/tests/view/5d79a0850ebc5902d3854d27 

Many thanks to @noobpwnftw for providing the extra cpu resources for fishtest, 
which led to me doing these tests. 

Closes https://github.com/official-stockfish/Stockfish/pull/2297 

Bench: 4024461 
 
Author: protonspring 
Date: Thu Sep 12 09:44:40 2019 +0200 
Timestamp: 1568274280 

Simplify Weak Lever 

This is a simplification that integrated WeakLever into doubled pawns. 
Since we already check for !support for Doubled pawns, it is trivial 
to check for weak lever by just checking more_than_one(lever). 

We also introduce the Score * bool operation overload to remove some 
casts in the code. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 26757 W: 5842 L: 5731 D: 15184 Elo +1.44
http://tests.stockfishchess.org/tests/view/5d77ee220ebc5902d384e5a4 

Closes https://github.com/official-stockfish/Stockfish/pull/2295 

No functional change 
 
Author: Stefan Geschwentner 
Date: Wed Sep 11 18:37:08 2019 +0200 
Timestamp: 1568219828 

Update reverse move stats 

For a good quiet non-pawn move consider the reverse move as bad 
and update the main history with a negative stat bonus. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 19292 W: 4401 L: 4141 D: 10750 Elo +4.68
http://tests.stockfishchess.org/tests/view/5d7751d50ebc594e7864973c 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 111952 W: 18762 L: 18275 D: 74915 Elo +1.51
http://tests.stockfishchess.org/tests/view/5d7771cf0ebc594e786498fa 

Closes https://github.com/official-stockfish/Stockfish/pull/2294 

Bench: 3914238