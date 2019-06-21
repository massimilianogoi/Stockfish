Stockfish Polyglot 2019-06-21

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1561042322 - More bonus for free passed pawn.

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

Changes since the last Stockfish Polyglot release:

Author: Vizvezdenec 
Date: Thu Jun 20 16:52:02 2019 +0200 
Timestamp: 1561042322 

More bonus for free passed pawn 

Give even more bonus to passed pawn if adjacent squares to its path 
are not attacked. 

passed STC 
http://tests.stockfishchess.org/tests/view/5d08c9b10ebc5925cf0a6630 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 175197 W: 39859 L: 38816 D: 96522 Elo +2.07

passed LTC 
http://tests.stockfishchess.org/tests/view/5d0ab8240ebc5925cf0a8fe4 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 92928 W: 16124 L: 15682 D: 61122 Elo +1.65

Bench: 3398333 
 
Author: Miguel Lahoz 
Date: Thu Jun 20 16:39:22 2019 +0200 
Timestamp: 1561041562 

Change multi-cut pruning condition 

Use comparison of eval with beta to predict potential cutNodes. This 
allows multi-cut pruning to also prune possibly mislabeled Pv and NonPv 
nodes. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 54305 W: 12302 L: 11867 D: 30136 Elo +2.78
http://tests.stockfishchess.org/tests/view/5d048ba50ebc5925cf0a15e8 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 189512 W: 32620 L: 31904 D: 124988 Elo +1.31
http://tests.stockfishchess.org/tests/view/5d04bf740ebc5925cf0a17f0 

Normally I would think such changes are risky, specially for PvNodes, 
but after trying a few other versions, it seems this version is more 
sound than I initially thought. 

Aside from this, a small funtional change is made to return 
singularBeta instead of beta to be more consistent with the fail-soft 
logic used in other parts of search. 

============================= 

How to continue from there ? 

We could try to audit other parts of the search where the "cutNode" 
variable is used, and try to use dynamic info based on heuristic 
eval rather than on this variable, to check if the idea behind this 
patch could also be applied successfuly. 

Bench: 3503788 
 
Author: VoyagerOne 
Date: Thu Jun 20 16:22:45 2019 +0200 
Timestamp: 1561040565 

QuietPick Speed-up 

Non-functional speedup: no need to generate, score, or sort quiet moves 
if SkipQuiet is true. Thanks to @mstembera for his suggestion. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.00,4.00] 
Total: 27910 W: 6406 L: 6129 D: 15375 Elo +3.45
http://tests.stockfishchess.org/tests/view/5d07e0920ebc5925cf0a58a8 

Closes https://github.com/official-stockfish/Stockfish/pull/2194 

No functional change 
 
Author: Joost VandeVondele 
Date: Thu Jun 20 16:15:57 2019 +0200 
Timestamp: 1561040157 

Fix progress issue with shuffling extensions 

Fixes issues #2126 and #2189 where no progress in rootDepth is made for particular fens: 

8/8/3P3k/8/1p6/8/1P6/1K3n2 b - - 0 1 
8/1r1rp1k1/1b1pPp2/2pP1Pp1/1pP3Pp/pP5P/P5K1/8 w - - 79 46 

the cause are the shuffle extensions. Upon closer analysis, it appears that in these cases a shuffle extension is made for every node searched, and progess can not be made. This patch implements a fix, namely to limit the number of extensions relative to the number of nodes searched. The ratio employed is 1/4, which fixes the issues seen so far, but it is a heuristic, and I expect that certain positions might require an even smaller fraction. 

The patch was tested as a bug fix and passed: 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 56601 W: 12633 L: 12581 D: 31387 Elo +0.32
http://tests.stockfishchess.org/tests/view/5d02b37a0ebc5925cf09f6da 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 52042 W: 8907 L: 8837 D: 34298 Elo +0.47
http://tests.stockfishchess.org/tests/view/5d0319420ebc5925cf09fe57 

Furthermore, to confirm that the shuffle extension in this form indeed still brings Elo, one more test at VLTC was performed: 
VLTC: 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 142022 W: 20963 L: 20435 D: 100624 Elo +1.29
http://tests.stockfishchess.org/tests/view/5d03630d0ebc5925cf0a011a 

Bench: 3961247 
 
Author: syzygy1 
Date: Thu Jun 20 16:09:40 2019 +0200 
Timestamp: 1561039780 

Partial revert of "Assorted trivial cleanups 5/2019". 

Since root_probe() and root_probe_wdl() do not reset all tbRank values if they fail, 
it is necessary to do this in rank_root_move(). This fixes issue #2196. 
Alternatively, the loop could be moved into both root_probe() and root_probe_wdl(). 

No functional change 
 
Author: VoyagerOne 
Date: Fri Jun 14 19:59:17 2019 +0200 
Timestamp: 1560535157 

Simplify SEE Pruning (#2191) 

Simplify SEE Pruning 
Note this should also be a speedup... 
If givesCheck is extended we know (except for DC) that it will have a positive SEE. So this new logic will be triggered before doing another expensive SEE function. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 24429 W: 5484 L: 5368 D: 13577 Elo +1.65
http://tests.stockfishchess.org/tests/view/5cffbccd0ebc5925cf09a154 

LTC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 28428 W: 4873 L: 4765 D: 18790 Elo +1.32
http://tests.stockfishchess.org/tests/view/5d0015f60ebc5925cf09acb1 

Bench: 3897263
 
Author: protonspring 
Date: Fri Jun 14 08:22:02 2019 +0200 
Timestamp: 1560493322 

Remove backmost_sq (#2190) 

This is a non-functional simplification. 

backmost_sq and frontmost_sq are redundant. It seems quite clear to always use frontmost_sq and use the correct color. 

Non functional change.
 
Author: Stefan Geschwentner 
Date: Fri Jun 14 07:36:42 2019 +0200 
Timestamp: 1560490602 

Increase pawns cache (#2187) 

Increase size of the pawns table by the factor 8. This decreases the number of recalculations of pawn structure information significantly (at least at LTC). 

I have done measurements for different depths and pawn cache sizes. 
First are given the number of pawn entry calculations are done (in parentheses is the frequency that a call to probe triggers a pawn entry calculation). The delta% are the percentage of less done pawn entry calculations in comparison to master 

VSTC: bench 1 1 12 
STC: bench 8 1 16 
LTC: bench 64 1 20 
VLTC: bench 512 1 24 

 VSTC STC LTC VLTC 
master 82218(6%) 548935(6%) 2415422(7%) 9548071(7%) 
pawncache*2 79859(6%) 492943(5%) 2084794(6%) 8275206(6%) 
pawncache*4 78551(6%) 458758(5%) 1827770(5%) 7112531(5%) 
pawncache*8 77963(6%) 439421(4%) 1649169(5%) 6128652(4%) 

delta%(p2-m) -2.9% -10.2% -13.7% -13.3% 
delta%(p4-m) -4.5% -16.4% -24.3% -25.5% 
delta%(p8-m) -5.2% -20.0% -31.7% -35.8% 

STC: (non-regression test because at STC the effect is smaller than at LTC) 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 22767 W: 5160 L: 5040 D: 12567 Elo +1.83
http://tests.stockfishchess.org/tests/view/5d00f6040ebc5925cf09c3e2 

LTC: 
LLR: 2.94 (-2.94,2.94) [0.00,4.00] 
Total: 26340 W: 4524 L: 4286 D: 17530 Elo +3.14
http://tests.stockfishchess.org/tests/view/5d00a3810ebc5925cf09ba16 

No functional change.
 
Author: VoyagerOne 
Date: Mon Jun 10 00:26:47 2019 +0200 
Timestamp: 1560119207 

No DC prune in QS (#2185) 

Don't prune discover checks in qSearch 

STC: 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 23176 W: 5320 L: 5039 D: 12817 Elo +4.21
http://tests.stockfishchess.org/tests/view/5cfbc9350ebc5925cf094ab3 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 128428 W: 22222 L: 21679 D: 84527 Elo +1.47
http://tests.stockfishchess.org/tests/view/5cfbf0b70ebc5925cf094ebc 

Bench: 3883245 
 
Author: Marco Costalba 
Date: Sun Jun 9 14:57:08 2019 +0200 
Timestamp: 1560085028 

Assorted trivial cleanups 5/2019 

No functional change. 

bench: 4178282 
 
Author: Stefan Geschwentner 
Date: Sun Jun 9 14:34:51 2019 +0200 
Timestamp: 1560083691 

Remove depth condition for ttPv (#2166) 

Currently PV nodes with a depth <= 4 were ignored for ttPv. Now remove this constraint and use all PV nodes. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 52209 W: 11755 L: 11694 D: 28760 Elo +0.41
http://tests.stockfishchess.org/tests/view/5cebc2d30ebc5925cf07b93a 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 20874 W: 3689 L: 3568 D: 13617 Elo +2.01
http://tests.stockfishchess.org/tests/view/5cec01fc0ebc5925cf07c62d 
 
Author: protonspring 
Date: Sun Jun 9 14:33:34 2019 +0200 
Timestamp: 1560083614 

Simplify passed pawns. (#2159) 

This is a functional simplification. 

If all of the stoppers are levers, a simple pawn push passes. 

STC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 41768 W: 9360 L: 9278 D: 23130 Elo +0.68
http://tests.stockfishchess.org/tests/view/5ce82ed60ebc5925cf073a79 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 40463 W: 6964 L: 6875 D: 26624 Elo +0.76
http://tests.stockfishchess.org/tests/view/5ce87d0b0ebc5925cf07472b 
 
Author: protonspring 
Date: Sun Jun 9 14:31:16 2019 +0200 
Timestamp: 1560083476 

Remove a few file_of's (simplify adjacent_files_bb) #2171 

This is a non-functional simplification that removes two file_of(s). 

STC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 22030 W: 5106 L: 4984 D: 11940 Elo +1.92
http://tests.stockfishchess.org/tests/view/5cf028de0ebc5925cf0839e7 
 
Author: protonspring 
Date: Sun Jun 9 14:28:42 2019 +0200 
Timestamp: 1560083322 

Simplify WeakUnopposedPawn #2181 

This is a functional simplification. 

Moves WeakUnopposedPawn to pawns.cpp and remove piece dependency. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 8699 W: 2000 L: 1853 D: 4846 Elo +5.87
http://tests.stockfishchess.org/tests/view/5cf7721b0ebc5925cf08ee79 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 46605 W: 7969 L: 7890 D: 30746 Elo +0.59
http://tests.stockfishchess.org/tests/view/5cf7d5f70ebc5925cf08fa96 
 
Author: VoyagerOne 
Date: Sun Jun 9 14:27:50 2019 +0200 
Timestamp: 1560083270 

SEE Pruning Tweak (#2183) 

Don't SEE prune any check extensions 

STC (yellow): 
LLR: -2.96 (-2.94,2.94) [0.50,4.50] 
Total: 129934 W: 29390 L: 28905 D: 71639 Elo +1.30
http://tests.stockfishchess.org/tests/view/5cf6b1a70ebc5925cf08dedb 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 102115 W: 17692 L: 17224 D: 67199 Elo +1.59
http://tests.stockfishchess.org/tests/view/5cf830710ebc5925cf090331 
 
Author: Michael Chaly 
Date: Sun Jun 9 14:26:53 2019 +0200 
Timestamp: 1560083213 

Advanced pawn pushes tweak (#2175) 

passed STC 
http://tests.stockfishchess.org/tests/view/5cf586ee0ebc5925cf08c0ed 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 29496 W: 6718 L: 6406 D: 16372 Elo +3.68

passed LTC 
http://tests.stockfishchess.org/tests/view/5cf59b630ebc5925cf08c343 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 40778 W: 7057 L: 6765 D: 26956 Elo +2.49

original idea from early 2018 by @jerrydonaldwatson 
Code slightly rewritten to be shorter and more logical, no functinal changes 
compared to passed patch. 
 
Author: protonspring 
Date: Sun Jun 9 14:24:06 2019 +0200 
Timestamp: 1560083046 

Simplify Outposts #2176 

This is a functional simplification. This is NOT the exact version that was tested. Beyond the testing, an assignment was removed and a piece changes for consistency. 

Instead of rewarding ANY square past an opponent pawn as an "outpost," only use squares that are protected by our pawn. I believe this is more consistent with what the chess world calls an "outpost." 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 23540 W: 5387 L: 5269 D: 12884 Elo +1.74
http://tests.stockfishchess.org/tests/view/5cf51e6d0ebc5925cf08b823 

LTC 
LLR: 2.94 (-2.94,2.94) [-3.00,1.00] 
Total: 53085 W: 9271 L: 9204 D: 34610 Elo +0.44
http://tests.stockfishchess.org/tests/view/5cf5279e0ebc5925cf08b992 

bench 3424592 
 
Author: 31m059 
Date: Sun Jun 9 14:19:07 2019 +0200 
Timestamp: 1560082747 

Simplify k-value for passers. Bench: 3854907 (#2182) 

Stockfish evaluates passed pawns in part based on a variable k, which shapes the passed pawn bonus based on the number of squares between the current square and promotion square that are attacked by enemy pieces, and the number defended by friendly ones. Prior to this commit, we gave a large bonus when all squares between the pawn and the promotion square were defended, and if they were not, a somewhat smaller bonus if at least the pawn's next square was. However, this distinction does not appear to provide any Elo at STC or LTC. 

Where do we go from here? Many promising Elo-gaining patches were attempted in the past few months to refine passed pawn calculation, by altering the definitions of unsafe and defended squares. Stockfish uses these definitions to choose the value of k, so those tests interact with this PR. Therefore, it may be worthwhile to retest previously promising but not-quite-passing tests in the vicinity of this patch. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 42344 W: 9455 L: 9374 D: 23515 Elo +0.66
http://tests.stockfishchess.org/tests/view/5cf83ede0ebc5925cf0904fb 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 69548 W: 11855 L: 11813 D: 45880 Elo +0.21
http://tests.stockfishchess.org/tests/view/5cf8698f0ebc5925cf0908c8 

Bench: 3854907 
