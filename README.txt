Stockfish Polyglot 2019-10-27 by Massimiliano Goi (c) - https://chess.massimilianogoi.com

--------------------------------------

Stockfish Polyglot is the same Stockfish with the ability to read Polyglot books (.bin format).
This chess engine can read up to four Polyglot books.

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1572045055 - Refactor final stats updates.

Changes since the last version:

Author: Joost VandeVondele 
Date: Sat Oct 26 01:10:55 2019 +0200 
Timestamp: 1572045055 

Refactor final stats updates. 

This PR refactors update_quiet_stats, update_capture_stats and search to more clearly reflect what is actually done. 

Effectively, all stat updates that need to be done after search is finished and a bestmove is found, 
are collected in a new function ```final_stats_update()```. This shortens our main search routine, and simplifies ```update_quiet_stats```. 
The latter function is now more easily reusable with fewer arguments, as the handling of ```quietsSearched``` is only needed in ```final_stats_update```. 
```update_capture_stats```, which was only called once is now integrated in ```final_stats_update```, which allows for removing a branch and reusing some ```stat_bonus``` calls. The need for refactoring was also suggested by the fact that the comments of ```update_quiet_stats``` and ```update_capture_stats``` were incorrect (e.g. ```update_capture_stats``` was called, correctly, also when the bestmove was a quiet and not a capture). 

passed non-regression STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 75196 W: 16364 L: 16347 D: 42485 Elo +0.08
http://tests.stockfishchess.org/tests/view/5db004ec0ebc5902c06db9e1 

The diff is most easily readable as ```git diff master --patience``` 

No functional change 
 
Author: Ste´phane Nicolet 
Date: Sat Oct 26 00:29:12 2019 +0200 
Timestamp: 1572042552 

Assorted trivial cleanups 

- Cleanups by Alain 
- Group king attacks and king defenses 
- Signature of futility_move_count() 
- Use is_discovery_check_on_king() 
- Simplify backward definition 
- Use static asserts in move generator 
- Factor a statement in move generator 

No functional change 
 
Author: Joost VandeVondele 
Date: Wed Oct 23 10:49:08 2019 +0200 
Timestamp: 1571820548 

Simplify reductions on singular extension 

Current master employs a scheme to adjust reductions on singular 
nodes that is somewhat controversial, see 
https://github.com/official-stockfish/Stockfish/pull/2167 

This patch removes this use of a search result outside of [a,b], 
by observing that the main effect of this code is to adjust the 
reduction by an average of ~2 (1.7) rather than 1. 

Claims the first blue at STC and LTC: 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 30142 W: 6547 L: 6442 D: 17153 Elo +1.21
http://tests.stockfishchess.org/tests/view/5daf16c40ebc5902c06da566 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 45715 W: 7380 L: 7298 D: 31037 Elo +0.62
http://tests.stockfishchess.org/tests/view/5daf2f3c0ebc5902c06da6c7 

Closes https://github.com/official-stockfish/Stockfish/pull/2367 

Bench: 5115841 
 
Author: Joost VandeVondele 
Date: Tue Oct 22 00:02:46 2019 +0200 
Timestamp: 1571695366 

Avoid crashing on Log File opening 

Stockfish crashes immediately if users enter a wrong file name (or even an existing 
folder name) for debug log file. It may be hard for users to find out since it prints 
nothing. If they enter the string via a chess GUI, the chess GUI may remember and 
auto-send to Stockfish next time, makes Stockfish crashes all the time. Bug report by 
Nguyen Hong Pham in this issue: https://github.com/official-stockfish/Stockfish/issues/2365 

This patch avoids the crash and instead prefers to exit gracefully with a error 
message on std:cerr, like we do with the fenFile for instance. 

Closes https://github.com/official-stockfish/Stockfish/pull/2366 

No functional change. 
 
Author: xoto10 
Date: Sun Oct 20 00:27:17 2019 +0200 
Timestamp: 1571524037 

Remove uithread 

With the current questions and issues around threading, I had a look at 
https://github.com/official-stockfish/Stockfish/issues/2299. 

It seems there was a problem with data races when requesting eval via UCI while 
a search was already running. To fix this an extra thread uithread was created, 
presumably to avoid an overlap with Threads.main() that was causing problems. 
Making this eval request seems to be outside the scope of UCI, and @vondele also 
reports that the data race is not even fixed reliably by this change. I suggest 
we simplify the threading here by removing this uithread and adding a comment 
signaling that user should not request eval when a search is already running. 

Closes https://github.com/official-stockfish/Stockfish/pull/2310 

No functional change. 
 
Author: VoyagerOne 
Date: Fri Oct 18 17:05:23 2019 +0200 
Timestamp: 1571411123 

Current capture for Counter-Move history 

Use current capture to index the CMH table instead of prior capture. 

STC: 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 61908 W: 13626 L: 13220 D: 35062 Elo +2.28
http://tests.stockfishchess.org/tests/view/5da8aa670ebc597ba8eda558 

LTC: 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 49057 W: 8071 L: 7765 D: 33221 Elo +2.17
http://tests.stockfishchess.org/tests/view/5da8e99d0ebc597ba8eda9ca 

Closes https://github.com/official-stockfish/Stockfish/pull/2362 

Bench: 4423737 
 
Author: Joost VandeVondele 
Date: Thu Oct 17 15:03:30 2019 +0200 
Timestamp: 1571317410 

Add four positions to bench 

The current bench is missing a position with high 50 moves rule counter, 
making most 'shuffle' tests based on 50mr > N seem non-functional. 
This patch adds one FEN with high 50mr counter to address this issue 
(taken from a recent tcec game). 

Four new FENs: 
- position with high 50mr counter 
- tactical position with many captures, checks, extensions, fails high/low 
- two losses by Stockfish in the S16 bonus games against Houdini 

See the pull request for nice comments by @Alayan-stk-2 about each position 
in bench: https://github.com/official-stockfish/Stockfish/pull/2338 

Bench: 4590210 
 
Author: VoyagerOne 
Date: Wed Oct 9 15:22:16 2019 +0900 
Timestamp: 1570602136 

Introduce separate counter-move tables for inCheck 

Enhance counter-move history table by adding a inCheck dimension. This doubles 
the size of the table but provides more accurate move ordering. 

STC: (yellow) 
LLR: -2.94 (-2.94,2.94) [0.50,4.50] 
Total: 36217 W: 7790 L: 7777 D: 20650 Elo +0.12
http://tests.stockfishchess.org/tests/view/5d9b9a290ebc5902b6d04fe0 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 36665 W: 6063 L: 5788 D: 24814 Elo +2.61
http://tests.stockfishchess.org/tests/view/5d9b9fcc0ebc5902b6d05985 

Closes https://github.com/official-stockfish/Stockfish/pull/2353 

Bench: 4053577 
 
Author: 31m059 
Date: Wed Oct 9 14:17:52 2019 +0900 
Timestamp: 1570598272 

No reachable outpost bonus for bishops 

Previously, we used various control statements and ternary operators to divide 
Outpost into four bonuses, based on whether the outpost was for a knight or 
bishop, and whether it was currently an Outpost or merely a potential ("reachable") 
one in the future. Bishop outposts, however, have traditionally been worth far 
less Elo in testing. An attempt to remove them altogether passed STC, but failed LTC. 

Here we include a narrower simplification, removing the reachable Outpost bonus 
for bishops. This bonus was always suspect, given that its current implementation 
conflicts directly with BishopPawns. BishopPawns penalizes our bishops based on the 
number of friendly pawns on the same color of square, but by definition, Outposts 
must be pawn-protected! This PR helps to alleviate this conceptual contradiction 
without loss of Elo and with slightly simpler code. 

On a code level, this allows us to simplify a ternary operator into the previous 
"if" block and distribute a multiplication into an existing constant Score. On a 
conceptual level, we retire one of the four traditional Outpost bonuses. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 22277 W: 4882 L: 4762 D: 12633 Elo +1.87
http://tests.stockfishchess.org/tests/view/5d9aeed60ebc5902b6cf9751 

LTC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 51206 W: 8353 L: 8280 D: 34573 Elo +0.50
http://tests.stockfishchess.org/tests/view/5d9af1940ebc5902b6cf9cd5 

Closes https://github.com/official-stockfish/Stockfish/pull/2352 

Bench: 3941591 
 
Author: Alayan 
Date: Mon Oct 7 22:30:04 2019 +0200 
Timestamp: 1570480204 

Adjust aspiration window with eval 

This patch changes the base aspiration window size depending on the absolute 
value of the previous iteration score, increasing it away from zero. This 
stems from the observation that the further away from zero, the more likely 
the evaluation is to change significantly with more depth. Conversely, a 
tighter aspiration window is more efficient when close to zero. 

A beneficial side-effect is that analysis of won positions without a quick 
mate is less prone to waste nodes in repeated fail-high that change the eval 
by tiny steps. 

STC: 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 60102 W: 13327 L: 12868 D: 33907 Elo +2.65
http://tests.stockfishchess.org/tests/view/5d9a70d40ebc5902b6cf39ba 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 155553 W: 25745 L: 25141 D: 104667 Elo +1.35
http://tests.stockfishchess.org/tests/view/5d9a7ca30ebc5902b6cf4028 

Future work : the values used in this patch were only a reasonable guess. 
Further testing should unveil more optimal values. However, the aspiration 
window is rather tight with a minimum of 21 internal units, so discrete 
integers put a practical limitation to such tweaking. 

More exotic experiments around the aspiration window parameters could also 
be tried, but efficient conditions to adjust the base aspiration window size 
or allow it to not be centered on the current evaluation are not obvious. 

The aspiration window increases after a fail-high or a fail-low is another 
avenue to explore for potential enhancements. 

Bench: 4043748 
 
Author: SFisGOD 
Date: Mon Oct 7 11:14:33 2019 +0200 
Timestamp: 1570439673 

Tweak kingFlankAttacks factor in kingDanger 

Increase kingFlankAttacks factor in kingDanger from 5/16 to 6/16. 

Failed STC: 
LLR: -2.96 (-2.94,2.94) [0.00,4.00] 
Total: 77947 W: 16989 L: 16848 D: 44110 Elo +0.63
http://tests.stockfishchess.org/tests/view/5d9ac0280ebc5902b6cf63cd 

Passed LTC 1: 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 13443 W: 2231 L: 2037 D: 9175 Elo +5.01
http://tests.stockfishchess.org/tests/view/5d9ac88d0ebc5902b6cf6ffb 

Passed LTC 2: 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 23340 W: 3842 L: 3617 D: 15881 Elo +3.35
http://tests.stockfishchess.org/tests/view/5d9acf7f0ebc5902b6cf7c27 

Closes https://github.com/official-stockfish/Stockfish/pull/2349 

Bench: 4042155 
 
Author: Alain SAVARD 
Date: Mon Oct 7 00:50:54 2019 +0200 
Timestamp: 1570402254 

Adjust pawn span 

Run as a simplification 

a) insures that pawn attacks are always included in the pawn span 
 (this "fixes" the case where some outpost or reachable outpost 
 bonus were awarded on squares controlled by enemy pawns). 

b) compute the full span only if not "backward" or not "blocked". 

By looking at "blocked" instead of "opposed", we get a nice simpli- 
fication and the "new" outpost detection is almost identical, except 
a few borderline cases on rank 4. 

passed STC 
http://tests.stockfishchess.org/tests/view/5d9950730ebc5902b6cefb90 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 79113 W: 17168 L: 17159 D: 44786 Elo +0.04

passed LTC 
http://tests.stockfishchess.org/tests/view/5d99d14e0ebc5902b6cf0692 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 41286 W: 6819 L: 6731 D: 27736 Elo +0.74

See https://github.com/official-stockfish/Stockfish/pull/2348 

bench: 3812891 
 
Author: Ondrej Mosnacek 
Date: Sun Oct 6 23:05:30 2019 +0200 
Timestamp: 1570395930 

Make priorCapture a bool 

It is always used as a bool, so let's make it a bool straight away. 
We can always redefine it as a Piece in a later patch if we want 
to use the piece type or the piece color. 

No functional change. 
 
Author: VoyagerOne 
Date: Sun Oct 6 02:04:19 2019 +0200 
Timestamp: 1570320259 

Introduce separate counter-move tables for captures 

Enhance counter-move history table by adding a capture/no-capture dimension, 
depending wether the previous move was a quiet move or a capture. This doubles 
the size of the table but provides more accurate move ordering. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 79702 W: 17720 L: 17164 D: 44818 Elo +2.42
http://tests.stockfishchess.org/tests/view/5d97945e0ebc590c21aa724b 

LTC: 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 29147 W: 4907 L: 4651 D: 19589 Elo +3.05
http://tests.stockfishchess.org/tests/view/5d97ccb90ebc590c21aa7bc0 

Closes https://github.com/official-stockfish/Stockfish/pull/2344 

Bench: 4131643 
 
Author: Brian Sheppard 
Date: Sun Oct 6 00:57:00 2019 +0200 
Timestamp: 1570316220 

Eliminate ONE_PLY 

Simplification that eliminates ONE_PLY, based on a suggestion in the forum that 
support for fractional plies has never been used, and @mcostalba's openness to 
the idea of eliminating it. We lose a little bit of type safety by making Depth 
an integer, but in return we simplify the code in search.cpp quite significantly. 

No functional change 

------------------------------------------ 

The argument favoring eliminating ONE_PLY: 

* The term “ONE_PLY” comes up in a lot of forum posts (474 to date) 
https://groups.google.com/forum/?fromgroups=#!searchin/fishcooking/ONE_PLY%7Csort:relevance 

* There is occasionally a commit that breaks invariance of the code 
with respect to ONE_PLY 
https://groups.google.com/forum/?fromgroups=#!searchin/fishcooking/ONE_PLY%7Csort:date/fishcooking/ZIPdYj6k0fk/KdNGcPWeBgAJ 

* To prevent such commits, there is a Travis CI hack that doubles ONE_PLY 
and rechecks bench 

* Sustaining ONE_PLY has, alas, not resulted in any improvements to the 
 engine, despite many individuals testing many experiments over 5 years. 

The strongest argument in favor of preserving ONE_PLY comes from @locutus: 
“If we use par example ONE_PLY=256 the parameter space is increases by the 
factor 256. So it seems very unlikely that the optimal setting is in the 
subspace of ONE_PLY=1.” 

There is a strong theoretical impediment to fractional depth systems: the 
transposition table uses depth to determine when a stored result is good 
enough to supply an answer for a current search. If you have fractional 
depths, then different pathways to the position can be at fractionally 
different depths. 

In the end, there are three separate times when a proposal to remove ONE_PLY 
was defeated by the suggestion to “give it a few more months.” So… it seems 
like time to remove this distraction from the community. 

See the pull request here: 
https://github.com/official-stockfish/Stockfish/pull/2289 
 
Author: Stephane Nicolet 
Date: Sat Oct 5 11:15:24 2019 +0200 
Timestamp: 1570266924 

Fix compare function in previous patch 

Bench: 4012371  
