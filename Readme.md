Stockfish Polyglot 2019-01-06

Stockfish Polyglot is none but the very own Stockfish with the only addition of the possibility to use Polyglot (.bin) books. In order to do that I used the library polybook.h and the C++ file polybook.cpp from Brainfish adding them to the Stockfish code with few other changes to make the polybook functions working. No functional changes to the original Stockfish algorythms were made.
Stockfish Polyglot features also the 'OwnBook' checkbox, so that the user can easily switch from the Polyglot book to the local CTG book (Chessbase softwares) or ABK book (Arena GUI). I've wandered through GitHub to recover the 'OwnBook' checkbox code (it needed just two mere rows..), luckily I've managed to find it and extract the part I needed to use.

Stockfish Polyglot 2019-01-11 https://chess.massimilianogoi.com

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1547135164 - Remove pvExact

The variable pvExact now overlaps with the pvHit concept. So you simplify 
the logic with small code tweaks to have pvHit trigger where pvExact 
previously triggered. 

passed STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 20558 W: 4497 L: 4373 D: 11688 Elo +2.10
http://tests.stockfishchess.org/tests/view/5c36e9fd0ebc596a450c7885 

passed LTC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 23482 W: 3888 L: 3772 D: 15822 Elo +1.72
http://tests.stockfishchess.org/tests/view/5c37072d0ebc596a450c7a52 

Bench: 3739723

CHANGES FROM THE PREVIOUS STOCKFISH POLYGLOT VERSION:

Author: mstembera 
Date: Thu Jan 10 16:36:59 2019 +0100 
Timestamp: 1547134619 

Minor cleanup to recent 'Flag critical search tree in hash table' patch 

No functional change 
 
Author: Joost VandeVondele 
Date: Wed Jan 9 16:57:24 2019 +0100 
Timestamp: 1547049444 

Small improvements to the CI infrastructure 

- avoid inlining for the debug testing so that suppressions work 
- provide more output for triggered errors 

No functional change. 
 
Author: MJZ1977 
Date: Wed Jan 9 15:05:33 2019 +0100 
Timestamp: 1547042733 

Flag critical search tree in hash table 

Introducing new concept, saving principal lines into the transposition table 
to generate a "critical search tree" which we can reuse later for intelligent 
pruning/extension decisions. 

For instance in this patch we just reduce reduction for these lines. But a lot 
of other ideas are possible. 

To go further : tune some parameters, how to add or remove lines from the 
critical search tree, how to use these lines in search choices, etc. 

STC : 
LLR: 2.94 (-2.94,2.94) [0.50,4.50] 
Total: 59761 W: 13321 L: 12863 D: 33577 Elo +2.66
http://tests.stockfishchess.org/tests/view/5c34da5d0ebc596a450c53d3 

LTC : 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 26826 W: 4439 L: 4191 D: 18196 Elo +3.21
http://tests.stockfishchess.org/tests/view/5c35ceb00ebc596a450c65b2 

Special thanks to Miguel Lahoz for his help in transposition table in/out. 

Bench: 3399866 
 
Author: Miguel Lahoz 
Date: Sun Jan 6 16:02:31 2019 +0100 
Timestamp: 1546786951 

Introduce Multi-Cut 

This was inspired after reading about 
[Multi-Cut](https://www.chessprogramming.org/Multi-Cut). 

We now do non-singular cut node pruning. The idea is to prune when we 
have a "backup plan" in case our expected fail high node does not fail 
high on the ttMove. 

For singular extensions, we do a search on all other moves but the 
ttMove. If this fails high on our original beta, this means that both 
the ttMove, as well as at least one other move was proven to fail high 
on a lower depth search. We then assume that one of these moves will 
work on a higher depth and prune. 

STC: 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 72952 W: 16104 L: 15583 D: 41265 Elo +2.48
http://tests.stockfishchess.org/tests/view/5c3119640ebc596a450c0be5 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 27103 W: 4564 L: 4314 D: 18225 Elo +3.20
http://tests.stockfishchess.org/tests/view/5c3184c00ebc596a450c1662 

Bench: 3145487

### Terms of use

Stockfish is free, and distributed under the **GNU General Public License**
(GPL). Essentially, this means that you are free to do almost exactly
what you want with the program, including distributing it among your
friends, making it available for download from your web site, selling
it (either by itself or as part of some bigger software package), or
using it as the starting point for a software project of your own.

The only real limitation is that whenever you distribute Stockfish in
some way, you must always include the full source code, or a pointer
to where the source code can be found. If you make any changes to the
source code, these changes must also be made available under the GPL.

For full details, read the copy of the GPL found in the file named
*Copying.txt*.
