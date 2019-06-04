Stockfish Polyglot 2019-06-04

Due to the missing of this feature in the main release I have decided
to create a Stockfish perfectly equal to the last beta version with
the capability to use Polyglot books (aka .bin or BIN).
In order to do that I used the library polyblook.h from Brainfish and
merged with the Stockfish code.


CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1559306139 - Scale lazy threshold according to material. (#2170).

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

---------------------------------------


Changes since the last Stockfish Polyglot release:

Author: protonspring 
Date: Fri May 31 14:35:39 2019 +0200 
Timestamp: 1559306139 

Scale lazy threshold according to material. (#2170) 

STC 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 58543 W: 13238 L: 12782 D: 32523 Elo +2.71
http://tests.stockfishchess.org/tests/view/5cef3efa0ebc5925cf081f07 

LTC 
LLR: 3.70 (-2.94,2.94) [0.00,3.50] 
Total: 82232 W: 14281 L: 13825 D: 54126 Elo +1.93
http://tests.stockfishchess.org/tests/view/5cef595d0ebc5925cf082441 

bench 3807737
 
Author: protonspring 
Date: Wed May 29 10:00:32 2019 +0200 
Timestamp: 1559116832 

Simplify semiopen_file (#2165) 

This is a non-functional simplification. Since our file_bb handles either Files or Squares, using Square here removes some code. Not likely any performance difference despite the test. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 6081 W: 1444 L: 1291 D: 3346 Elo +8.74
http://tests.stockfishchess.org/tests/view/5ceb3e2e0ebc5925cf07ab03 

Non functional change.
 
Author: Joost VandeVondele 
Date: Sat May 25 09:43:52 2019 +0200 
Timestamp: 1558770232 

Remove one division. (#2158) 

Can be included in the earlier calculation, with a small rounding difference. 

passed STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 17912 W: 4044 L: 3915 D: 9953 Elo +2.50
http://tests.stockfishchess.org/tests/view/5ce711f90ebc5925cf070d0e 

passed LTC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 56061 W: 9579 L: 9516 D: 36966 Elo +0.39
http://tests.stockfishchess.org/tests/view/5ce716820ebc5925cf070e37 

Bench: 3817662
 
Author: 31m059 
Date: Fri May 17 13:38:23 2019 +0200 
Timestamp: 1558093103 

Allow RQ through pieces. Bench: 3415326 (#2153) 

We evaluate defended and unsafe squares for a passed pawn push based on friendly and enemy rooks and queens on the passed pawn's file. Prior to this patch, we further required that these rooks and queens be able to directly attack the passed pawn. However, this restriction appears unnecessary and worth almost exactly 0 Elo at LTC. 

The simplified code allows rooks and queens to attack/defend the passed pawn through other pieces of either color. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 29019 W: 6488 L: 6381 D: 16150 Elo +1.28
http://tests.stockfishchess.org/tests/view/5cdcf7270ebc5925cf05d30c 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 54224 W: 9200 L: 9133 D: 35891 Elo +0.43
http://tests.stockfishchess.org/tests/view/5cddc6210ebc5925cf05eca3 

Bench: 3415326
 
Author: svivanov72 
Date: Thu May 16 14:14:11 2019 +0200 
Timestamp: 1558008851 

Remove unused code (#2150) 

Remove an unused operator in has_game_cycle (thanks @vondele) 
and modify its comment to explain other code. 

No functional change.
 
Author: protonspring 
Date: Thu May 16 14:13:16 2019 +0200 
Timestamp: 1558008796 

Score and Select Best Thread in same loop (#2125) 

This is a non-functional simplification that combines vote counting and thread selecting in the same loop. 

It is possible that the best thread would be updated more frequently than master, but I'm not sure it matters here. Perhaps "mostVotes" is a better name than "bestVote?" 

STC (stopped early). 
LLR: 0.70 (-2.94,2.94) [-3.00,1.00] 
Total: 10714 W: 2329 L: 2311 D: 6074 Elo +0.58
http://tests.stockfishchess.org/tests/view/5ccc71470ebc5925cf03d244 

No functional change.
 
Author: protonspring 
Date: Thu May 16 14:11:00 2019 +0200 
Timestamp: 1558008660 

Consolidate some code in set_state. (#2151) 

Non functional change. 
