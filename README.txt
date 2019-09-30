Stockfish Polyglot 2019-09-30 by Massimiliano Goi (c) - https://chess.massimilianogoi.com

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

This distribution is the expansion of Stockfish beta having timestamp: Timestamp: 1569581207 - Extend castling independently of singular extension.

Changes since the last version:

Author: 31m059 
Date: Fri Sep 27 12:46:47 2019 +0200 
Timestamp: 1569581207 

Extend castling independently of singular extension 

A curious feature of Stockfish's current extension code is its repeated 
use of "else if." In most cases, this makes no functional difference, 
because no more than one extension is applied; once one extension has 
been applied, the remaining ones can be safely ignored. 

However, if most singular extension search conditions are true, except 
"value < singularBeta", no non-singular extensions (e.g., castling) can 
be performed! 

Three tests were submitted, for three of Stockfish's four non-singular 
extensions. I excluded the shuffle extension, because historically there 
have been concerns about the fragility of its conditions, and I did not 
want to risk causing any serious search problems. 

- Modifying the passed pawn extension appeared roughly neutral at STC. At 
best, it appeared to be an improvement of less than 1 Elo. 
- Modifying check extension performed very poorly at STC 
- Modifying castling extension (this patch) produced a long "yellow" run 
 at STC (insufficient to pass, but positive score) and a strong LTC. 

In simple terms, prior to this patch castling extension was occasionally 
not applied during search--on castling moves. The effect of this patch is 
to perform castling extension on more castling moves. It does so without 
adding any code complexity, simply by replacing an "else if" with "if" and 
reordering some existing code. 

STC: 
LLR: -2.96 (-2.94,2.94) [0.00,4.00] 
Total: 108114 W: 23877 L: 23615 D: 60622 Elo +0.84
http://tests.stockfishchess.org/tests/view/5d8d86bd0ebc590f3beb0c88 

LTC: 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 20862 W: 3517 L: 3298 D: 14047 Elo +3.65
http://tests.stockfishchess.org/tests/view/5d8d99cd0ebc590f3beb1899 

Bench: 3728191 

-------- 

Where do we go from here? 

- It seems strange to me that check extension performed so poorly -- clearly 
some of the singular extension conditions are also very important for check 
extension. I am not an expert in search, and I do not have any intuition 
about which of the eight conditions is/are the culprit. I will try a 
succession of eight STC tests to identify the relevant conditions, then try 
to replicate this PR for check extension. 

- Recent tests interacting with the castle extension may deserve retesting. 
I will shortly resubmit a few of my recent castling extension tweaks, rebased 
on this PR/commit. 

My deepest thanks to @noobpwnftw for the extraordinary CPU donation, and to 
all our other fishtest volunteers, who made it possible for a speculative LTC 
to pass in 70 minutes! 

Closes https://github.com/official-stockfish/Stockfish/pull/2331 
 
Author: Alain SAVARD 
Date: Fri Sep 27 12:37:49 2019 +0200 
Timestamp: 1569580669 

Simplify RookOnPawn 

Remove the RookOnPawn logic (for rook on rank 5 and above aligning with pawns 
on same row or file) which was overlapping with a few other parameters. 

Inspired by @31m059 interesting result hinting that a direct attack on pawns 
instead of PseudoAttacks might work. 
http://tests.stockfishchess.org/tests/view/5d89a7c70ebc595091801b8d 

After a few attempts by me and @31m059, and some long STC greens but red LTC, 
as a proof of concept I first tried a local SPSA at VSTC trying to tune related 
rook psqt rows, and mainly some rook related stuff in evaluate.cpp. 
Result was STC green, but still red LTC, 

Finally a 100M fishtest SPSA at LTC proved successful both at STC and LTC. 

All this was possible with the awesome fishtest contributors. 
At some point, I had 850 workers on the last test ! 

Run as a simplification 

STC 
http://tests.stockfishchess.org/tests/view/5d8d68f40ebc590f3beaf171 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 7399 W: 1693 L: 1543 D: 4163 Elo +7.04

LTC 
http://tests.stockfishchess.org/tests/view/5d8d70270ebc590f3beaf63c 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 41617 W: 6981 L: 6894 D: 27742 Elo +0.73

Closes https://github.com/official-stockfish/Stockfish/pull/2329 

bench: 4037914 
 
Author: Joost VandeVondele 
Date: Fri Sep 27 00:16:49 2019 +0200 
Timestamp: 1569536209 

Remove custom mutex implementation 

As part of the investigation of the hang caused by an incorrect implementation 
of condition_variable in libwinpthread, it was realized that our custom Mutex 
implementation is no longer needed. Prior to lazySMP this custom implementation 
resulted in a 30% speedup, but now no speed difference can be measured as no 
mutex is used on the hot path in lazySMP. 

https://github.com/official-stockfish/Stockfish/issues/2291 
https://github.com/official-stockfish/Stockfish/issues/2309#issuecomment-533733393 https://github.com/official-stockfish/Stockfish/issues/2309#issuecomment-533737515 

The interest of this patch is that it removes platform-specific code, which is 
always less tested. 

No functional change. 
 
Author: Ste큣hane Nicolet 
Date: Thu Sep 26 23:27:48 2019 +0200 
Timestamp: 1569533268 

Restore development version (revert previous commit) 

Revert the previous patch now that the binary for the super-final 
of TCEC season 16 has been sent. 

Maybe the feature of showing the name of compiler will be added to the 
master branch in the future. But we may use a cleaner way to code it, see 
some ideas using the Makefile approach at the end of pull request #2327 : 
https://github.com/official-stockfish/Stockfish/pull/2327 

Bench: 3618154 
 
Author: Ste큣hane Nicolet 
Date: Wed Sep 25 22:28:51 2019 +0200 
Timestamp: 1569443331 

Temporary patch to show the compiler for TCEC submission 

This patch shows a description of the compiler used to compile Stockfish, 
when starting from the console. 

Usage: 

``` 
./stockfish 
compiler 
``` 

Example of output: 

``` 
Stockfish 240919 64 POPCNT by T. Romstad, M. Costalba, J. Kiiski, G. Linscott 

Compiled by clang++ 9.0.0 on Apple 
 __VERSION__ macro expands to: 4.2.1 Compatible Apple LLVM 9.0.0 (clang-900.0.38) 
``` 

No functional change 
 
Author: Ste큣hane Nicolet 
Date: Tue Sep 24 12:54:02 2019 +0200 
Timestamp: 1569322442 

Increase weight for supported pawns 

This patch changes the weight for counting supports of pawns 
from 17 to 21. Hopefully Stockfish will accept to play a bit 
more of closed or semi-closed positions. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.00,4.00] 
Total: 13822 W: 3158 L: 2939 D: 7725 Elo +5.51
http://tests.stockfishchess.org/tests/view/5d89c3a10ebc595091802379 

LTC: 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 63066 W: 10590 L: 10236 D: 42240 Elo +1.95
http://tests.stockfishchess.org/tests/view/5d89ca7f0ebc595091802680 

Future work: try to tweak the evaluation to better understand 
the French structures. 

Closes https://github.com/official-stockfish/Stockfish/pull/2326 

Bench: 3618154 
 
Author: nickpelling 
Date: Tue Sep 24 10:05:54 2019 +0200 
Timestamp: 1569312354 

Clarify the mapping of files to queenside 

This patch replaces the obscure expressions mapping files ABCDEFGH to ABCDDCBA 
by explicite calls to an auxiliary function: 

 old: f = min(f, ~f) 
 new: f = map_to_queenside(f) 

We used the Golbolt web site (https://godbolt.org) to check that the current 
code for the auxiliary function is optimal. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 30292 W: 6756 L: 6651 D: 16885 Elo +1.20
http://tests.stockfishchess.org/tests/view/5d8676720ebc5971531d6aa1 

Achieved with a bit of help from Sopel97, snicolet and vondele, thanks everyone! 
Closes https://github.com/official-stockfish/Stockfish/pull/2325 

No functional change 
 
Author: xoto10 
Date: Mon Sep 23 09:50:34 2019 +0200 
Timestamp: 1569225034 

Encourage rook lift to third rank 

This change to the Rook psqt encourages rook lifts to the third rank 
on the two center files. 

STC 10+0.1 th 1 : 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 40654 W: 9028 L: 8704 D: 22922 Elo +2.77
http://tests.stockfishchess.org/tests/view/5d885da60ebc5906dd3e9fcd 

LTC 60+0.6 th 1 : 
LLR: 2.96 (-2.94,2.94) [0.00,4.00] 
Total: 56963 W: 9530 L: 9196 D: 38237 Elo +2.04
http://tests.stockfishchess.org/tests/view/5d88618c0ebc5906dd3ea45f 

Thanks to @snicolet for mentioning that Komodo does this a lot and 
Stockfish doesn't, which gave me the idea for this patch, and to 
@noobpwnftw for providing cores to fishtest which allowed very quick 
testing. 

Future work: perhaps this can be refined somehow to encourage this 
on other files, my attempts have failed. 

Closes https://github.com/official-stockfish/Stockfish/pull/2322 

Bench: 3950249 
 
Author: Ste큣hane Nicolet 
Date: Mon Sep 23 09:10:28 2019 +0200 
Timestamp: 1569222628 

Revert "Clarify the mapping of files to queenside" 

This reverts commit 7756344d5d2b93970e7cd423f8cbf6fb1da11b74. 
 
Author: Ste큣hane Nicolet 
Date: Mon Sep 23 08:54:20 2019 +0200 
Timestamp: 1569221660 

Clarify the mapping of files to queenside 

Author: @nickpelling 

We replace in the code the obscure expressions mapping files ABCDEFGH to ABCDDCBA 
by an explicite call to an auxiliary function : 

 old: f = min(f, ~f) 
 new: f = map_to_queenside(f) 

We used the Golbolt web site (https://godbolt.org) to find the optimal code 
for the auxiliary function. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 30292 W: 6756 L: 6651 D: 16885 Elo +1.20
http://tests.stockfishchess.org/tests/view/5d8676720ebc5971531d6aa1 

No functional change 
 
Author: Joost VandeVondele 
Date: Mon Sep 23 07:29:00 2019 +0200 
Timestamp: 1569216540 

More random draw evaluations 

Use the randomized draw function value_draw() also for draw evalutions. 

This extends the earlier commit 
https://github.com/official-stockfish/Stockfish/commit/97d2cc9a9c1c4b6ff1b470676fa18c7fc6509886 
which did this only for 3folds. 

As in that case, this test was yellow at STC and LTC, but green at VLTC, 
indicative of the fact that the higher the drawrate, the more likely this 
idea is beneficial. 

STC: 
LLR: -2.96 (-2.94,2.94) [0.50,4.50] 
Total: 83573 W: 18584 L: 18335 D: 46654 Elo +1.04
http://tests.stockfishchess.org/tests/view/5d84e44d0ebc5971531d4f94 

LTC: 
LLR: -2.96 (-2.94,2.94) [0.00,3.50] 
Total: 92252 W: 15240 L: 15160 D: 61852 Elo +0.30
http://tests.stockfishchess.org/tests/view/5d865dd90ebc5971531d68e1 

VLTC: 120+1.2 @ 2th 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 51902 W: 7323 L: 7028 D: 37551 Elo +1.97
http://tests.stockfishchess.org/tests/view/5d8763620ebc595f57c22b15 

Closes https://github.com/official-stockfish/Stockfish/pull/2321 

Bench: 3441237 
 
Author: protonspring 
Date: Mon Sep 23 07:12:32 2019 +0200 
Timestamp: 1569215552 

Simplify connected pawn scoring 

When scoring the connected pawns, replace the intricate ternary expressions 
choosing the coefficient by a simpler addition of boolean conditions: 

` value = Connected * (2 + phalanx - opposed) ` 

This is the map showing the old coefficients and the new ones: 

``` 
phalanx and unopposed: 3x -> 3x 
phalanx and opposed: 1.5x -> 2x 
not phalanx and unopposed: 2x -> 2x 
not phalanx and opposed: 1x -> 1x 
``` 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 11354 W: 2579 L: 2437 D: 6338 Elo +4.35
http://tests.stockfishchess.org/tests/view/5d8151f00ebc5971531d244f 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 41221 W: 7001 L: 6913 D: 27307 Elo +0.74
http://tests.stockfishchess.org/tests/view/5d818f930ebc5971531d26d6 

Bench: 3959889 

blah 
 
Author: Joost VandeVondele 
Date: Mon Sep 23 06:47:59 2019 +0200 
Timestamp: 1569214079 

Acknowledge fishtest authors 

Explicitly acknowledge fishtest authors. 
Their efforts are almost invisible, but essential for the project. 

Many thanks to https://github.com/glinscott/fishtest/blob/master/AUTHORS ! 

No functional change. 
 
Author: noobpwnftw 
Date: Mon Sep 16 15:09:45 2019 +0200 
Timestamp: 1568639385 

Raise stack size to 8MB for pthreads 

It seems there is no other way to specify stack size on std::thread than linker 
flags and the effective flags are named differently in many toolchains. On 
toolchains where pthread is always available, this patch changes the stack 
size change in our C++ code via pthread to ensure a minimum stack size of 8MB, 
instead of relying on linker defaults which may be platform-specific. 

Also raises default stack size on OSX to current Linux default (8MB) just to 
be safe. 

Closes https://github.com/official-stockfish/Stockfish/pull/2303 

No functional change 
 
Author: Ste큣hane Nicolet 
Date: Mon Sep 16 01:37:39 2019 +0200 
Timestamp: 1568590659 

Scale down endgame factor when shuffling 

This patch decreases the endgame scale factor using the 50 moves counter. 
Looking at some games with this patch, it seems to have two effects on 
the playing style: 

1) when no progress can be made in late endgames (for instance in fortresses 
 or opposite bishops endgames) the evaluation will be largely tamed down 
 towards a draw value. 

2) more interestingly, there is also a small effect in the midgame play because 
 Stockfish will panic a little bit if there are more than four consecutive 
 shuffling moves with an advantage: the engine will try to move a pawn or to 
 exchange a piece to keep the advantage, so the follow-ups of the position 
 will be discovered earlier by the alpha-beta search. 

passed STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 23017 W: 5080 L: 4805 D: 13132 Elo +4.15
http://tests.stockfishchess.org/tests/view/5d7e4aef0ebc59069c36fc74 

passed LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 30746 W: 5171 L: 4911 D: 20664 Elo +2.94
http://tests.stockfishchess.org/tests/view/5d7e513d0ebc59069c36ff26 

Pull request: https://github.com/official-stockfish/Stockfish/pull/2304 

Bench: 4272173 
 
Author: Vizvezdenec 
Date: Sun Sep 15 00:32:54 2019 +0200 
Timestamp: 1568500374 

Introduce midgame initiative 

This patch finally introduces something that was tried for years: midgame score 
dependance on complexity of position. More precisely, if the position is very 
simplified and the complexity measure calculated in the initiative() function 
is inferior to -50 by an amount d, then we add this value d to the midgame score. 

One example of play of this patch will be (again!) 4 vs 3 etc same flank endgames 
where sides have a lot of non-pawn material: 4 vs 3 draw mostly remains the same 
draw even if we add a lot of equal material to both sides. 

STC run was stopped after 200k games (and not converging): 
LLR: -1.75 (-2.94,2.94) [0.50,4.50] 
Total: 200319 W: 44197 L: 43310 D: 112812 Elo +1.54
http://tests.stockfishchess.org/tests/view/5d7cfdb10ebc5902d386572c 

passed LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 41051 W: 6858 L: 6570 D: 27623 Elo +2.44
http://tests.stockfishchess.org/tests/view/5d7d14680ebc5902d3866196 

This is the first and not really precise version, a lot of other stuff can be 
tried on top of it (separate complexity for middlegame, some more terms, even 
simple retuning of values). 

Bench: 4248476 
 
Author: Ste큣hane Nicolet 
Date: Sat Sep 14 08:33:00 2019 +0200 
Timestamp: 1568442780 

Assorted trivial cleanups 

No functional change 
 
Author: 31m059 
Date: Sat Sep 14 07:47:05 2019 +0200 
Timestamp: 1568440025 

Use queens of either color in RookOnQueenFile 

The recently-added RookOnQueenFile evaluation term (36e4a86) provided a bonus 
for placing our rook on the same file as an enemy queen. 

Here, we relax a condition in this bonus, broadening its effect to any queen. 
It is also strategically desirable to place the rook on the same file as a friendly 
queen, so the restriction on the queen's color is removed. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 66856 W: 14847 L: 14815 D: 37194 Elo +0.17
http://tests.stockfishchess.org/tests/view/5d7b3c6a0ebc5902d385bcf5 

LTC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 86786 W: 14264 L: 14248 D: 58274 Elo +0.06
http://tests.stockfishchess.org/tests/view/5d7b4e9b0ebc5902d385c178 

Closes https://github.com/official-stockfish/Stockfish/pull/2302 

Bench: 3703909 
 
Author: Ste큣hane Nicolet 
Date: Sat Sep 14 07:34:19 2019 +0200 
Timestamp: 1568439259 

Update Makefile documentation 

Follow-up to previous commit. Update the documentation for the user when using `make`, 
to show the preferred bmi2 compile in the advanced examples section. 

Note: I made a mistake in the previous commit comment, the documentation is shown when 
using `make` or `make help`, not `make --help`. 

No functional change 
 
Author: Joost VandeVondele 
Date: Sat Sep 14 07:11:23 2019 +0200 
Timestamp: 1568437883 

Add sse4 if bmi2 is enabled 

The only change done to the Makefile to get a somewhat faster binary as 
discussed in #2291 is to add -msse4 to the compile options of the bmi2 build. 
Since all processors supporting bmi2 also support sse4 this can be done easily. 
It is a useful step to avoid sending around custom and poorly tested builds. 

The speedup isn't enough to pass [0,4] but it is roughly 1.15Elo and a LOS of 90%: 
LLR: -2.95 (-2.94,2.94) [0.00,4.00] 
Total: 93009 W: 20519 L: 20316 D: 52174 Elo +0.76

Also rewrite the documentation for the user when using `make --help`, so that 
the order of architectures for x86-64 has the more performant build one on top. 

Closes https://github.com/official-stockfish/Stockfish/pull/2300 

No functional change  
