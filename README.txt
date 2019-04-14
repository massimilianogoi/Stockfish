Stockfish Polyglot 2019-04-13

Downloaded from https://chess.massimilianogoi.com

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

Due to the missing of this feature in the main release I have decided
to create a Stockfish perfectly equal to the last beta version with
the capability to use Polyglot books (aka .bin or BIN).
In order to do that I used the library polyblook.h from Brainfish and
merged with the Stockfish code.

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1555069684 - Revert "Shuffle detection #2064".
The value max_threads = std::thread::hardware_concurrency(); has been added to ucioption.cpp so that the
engine settings dialog box is set by default with the maximum number of threads.


Changes since the last Stockfish Polyglot release:

Author: Massimiliano Goi 
Date: Sat Apr 13 23:30:04 2019 +0200 

The value max_threads = std::thread::hardware_concurrency(); has been added to ucioption.cpp so that the
engine settings dialog box is set by default with the maximum number of threads.

Author: Marco Costalba 
Date: Fri Apr 12 13:48:04 2019 +0200 
Timestamp: 1555069684 

Revert "Shuffle detection #2064" 

It causes a serious regression hanging a simple fixed 
depth search. Reproducible with: 

position fen q1B5/1P1q4/8/8/8/6R1/8/1K1k4 w - - 0 1 
go depth 13 

The reason is a search tree explosion due to: 

if (... && depth < 3 * ONE_PLY) 
 extension = ONE_PLY; 

This is very dangerous code by itself because triggers **at the leafs** 
and in the above position keeps extending endlessly. In normal games 
time deadline makes the search to stop sooner or later, but in fixed 
seacrch we just hang possibly for a very long time. This is not acceptable 
because 'go depth 13' shall not be a surprise for any position. 

This patch reverts commit 76f1807baa90eb69f66001d25df2a28533f9406f. 
and fixes the issue https://github.com/official-stockfish/Stockfish/issues/2091 

Bench: 3243738 
 
Author: miguel-l 
Date: Wed Apr 10 19:35:47 2019 +0200 
Timestamp: 1554917747 

Extend dangerous passed pawn moves (#2089) 

Introduce a new search extension when pushing an advanced passed pawn is 
also suggested by the first killer move. There have been previous tests 
which have similar ideas, mostly about pawn pushes, but it seems to be 
overkill to extend too many moves. My idea is to limit the extension to 
when a move happens to be noteworthy in some other way as well, such as 
in this case, when it is also a killer move. 

STC: 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 19027 W: 4326 L: 4067 D: 10634 Elo +4.73
http://tests.stockfishchess.org/tests/view/5cac2cde0ebc5925cf00c36d 

LTC: 
LLR: 2.94 (-2.94,2.94) [0.00,3.50] 
Total: 93390 W: 15995 L: 15555 D: 61840 Elo +1.64
http://tests.stockfishchess.org/tests/view/5cac42270ebc5925cf00c4b9 

For future tests, it looks like this will interact heavily with passed 
pawn evaluation. It may be good to try more variants of some of the more 
promising evaluations tests/tweaks. 

Bench: 3666092
 
Author: protonspring 
Date: Wed Apr 10 19:33:57 2019 +0200 
Timestamp: 1554917637 

Simplify castlingPath (#2088) 

Instead of looping through kfrom,kto, rfrom, rto, we can use BetweenBB. This is less lines of code and it is more clear what castlingPath actually is. Personal benchmarks are all over the place. However, this code is only executed when loading a position, so performance doesn't seem that relevant. 

No functional change. 
 
Author: 31m059 
Date: Tue Apr 9 19:35:17 2019 +0200 
Timestamp: 1554831317 

Raise kingDanger threshold and adjust constant term #2087 

The kingDanger term is intended to give a penalty which increases rapidly in the middlegame but less so in the endgame. To this end, the middlegame component is quadratic, and the endgame component is linear. However, this produces unintended consequences for relatively small values of kingDanger: the endgame penalty will exceed the middlegame penalty. This remains true up to kingDanger = 256 (a S(16, 16) penalty), so some of these inaccurate penalties are actually rather large. 

In this patch, we increase the threshold for applying the kingDanger penalty to eliminate some of this unintended behavior. This was very nearly, but not quite, sufficient to pass on its own. The patch was finally successful by integrating a second kingDanger tweak by @Vizvezdenec, increasing the kingDanger constant term slightly and improving both STC and LTC performance. 

Where do we go from here? I propose that in the future, any attempts to tune kingDanger coefficients should also consider tuning the kingDanger threshold. The evidence shows clearly that it should not be automatically taken to be zero. 

Special thanks to @Vizvezdenec for the kingDanger constant tweak. Thanks also to all the approvers and CPU donors who made this possible! 

STC: 
LLR: -2.96 (-2.94,2.94) [0.00,4.00] 
Total: 141225 W: 31239 L: 30846 D: 79140 Elo +0.97
http://tests.stockfishchess.org/tests/view/5cabbdb20ebc5925cf00b86c 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,4.00] 
Total: 30708 W: 5296 L: 5043 D: 20369 Elo +2.86
http://tests.stockfishchess.org/tests/view/5cabff760ebc5925cf00c22d 

Bench: 3445945
 
Author: protonspring 
Date: Tue Apr 9 13:46:12 2019 +0200 
Timestamp: 1554810372 

Remove BetweenBB Array #2076 

Non functional change. 
 
Author: Marco Costalba 
Date: Sat Apr 6 12:43:41 2019 +0200 
Timestamp: 1554547421 

Fix sed for OS X (#2080) 

The sed command is a bit different in Mac OS X (why not!). 

The ‘-i’ option required a parameter to tell what extension to add for the 
backup file. To fix it, just add extension for backup file, for example ‘.bak’ 

Fix broken Trevis CI test 

No functional change.
 
Author: erbsenzaehler 
Date: Sat Apr 6 11:15:17 2019 +0200 
Timestamp: 1554542117 

Make ONE_PLY value independent again 

And a Trevis CI test to catch future issues. 

No functional change. 
 
Author: Marco Costalba 
Date: Sat Apr 6 02:03:15 2019 +0200 
Timestamp: 1554508995 

Fix a missing assignment in previous commit 

While reformatting the patch, I got wrong a statement and converted it badly.
 
Author: xoto10 
Date: Fri Apr 5 20:37:16 2019 +0200 
Timestamp: 1554489436 

Use average bestMoveChanges across all threads #2072 

The current update only by main thread depends on the luck of 
whether main thread sees any/many changes to the best move or not. 
It then makes large, lumpy changes to the time to be 
used (1x, 2x, 3x, etc) depending on that sample of 1. 
Use the average across all threads to get a more reliable 
number with a smoother distribution. 

STC @ 5+0.05 th 4 : 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 51899 W: 11446 L: 11029 D: 29424 Elo +2.79
http://tests.stockfishchess.org/tests/view/5ca32ff20ebc5925cf0016fb 

STC @ 5+0.05 th 8 : 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 13851 W: 2843 L: 2620 D: 8388 Elo +5.59
http://tests.stockfishchess.org/tests/view/5ca35ae00ebc5925cf001adb 

LTC @ 20+0.2 th 8 : 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 48527 W: 7941 L: 7635 D: 32951 Elo +2.19
http://tests.stockfishchess.org/tests/view/5ca37cb70ebc5925cf001cec 

Further work: 
Similar changes might be possible for the fallingEval and timeReduction calculations (and elsewhere?), using either the min, average or max values across all threads. 

Bench 3506898 
 
Author: Moez Jellouli 
Date: Thu Apr 4 09:40:34 2019 +0200 
Timestamp: 1554363634 

Remove pureStaticEval #2069 

Remove pureStaticEval variable and keep only one 
static evaluation (ss->staticEval). 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 64617 W: 14348 L: 14312 D: 35957 Elo +0.19
http://tests.stockfishchess.org/tests/view/5c9e1ad70ebc5925cfffc106 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 82200 W: 13703 L: 13680 D: 54817 Elo +0.10
http://tests.stockfishchess.org/tests/view/5c9e4efd0ebc5925cfffc68b 

Bench : 3506898 
 
Author: Moez Jellouli 
Date: Thu Apr 4 08:49:35 2019 +0200 
Timestamp: 1554360575 

Add attacked by 2 pawns to attackedBy2 (#2074) 

Add squares attacked by 2 pawns to the attackedBy2 array 

STC : 
LLR: -2.95 (-2.94,2.94) [0.50,4.50] 
Total: 132722 W: 29583 L: 29090 D: 74049 Elo +1.29
http://tests.stockfishchess.org/tests/view/5ca231ba0ebc5925cf000794 

LTC : 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 94589 W: 16161 L: 15718 D: 62710 Elo +1.63
http://tests.stockfishchess.org/tests/view/5ca25d180ebc5925cf000ba4 

Bench: 3337864 
