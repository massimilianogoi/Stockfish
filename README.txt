Stockfish Polyglot 2019-08-24

--------------------------------------

Due to the missing of this feature in the main release I have decided
to create a Stockfish perfectly equal to the last beta version with
the capability to use Polyglot books (aka .bin or BIN).
In order to do that I used the library polyblook.h from Brainfish and
merged with the Stockfish code.

NOVELTY: I have introduced an addition, now you can use up to four Polyglot books at once.

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

Maximize its performance buying the Goi 6.1 book: https://chess.massimilianogoi.com/shop/goiopeningbook/

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1566627690 - Improve signature of evaluate_shelter().

Author: massimilianogoi 
Date: Thu Aug 24 11:20:00 2019 +0200 

Raised the text boxes to write the books address to four in ucioption.cpp

Author: massimilianogoi 
Date: Thu Aug 24 11:20:00 2019 +0200 

Added the global variables PolyBook polybook3 and Polybook polybook4 to polybook.cpp.

Author: massimilianogoi 
Date: Thu Aug 24 11:20:00 2019 +0200 

Added extern PolyBook polybook3 and extern PolyBook polybook4; in polybook.h

Author: massimilianogoi 
Date: Thu Aug 24 11:20:00 2019 +0200 

Added the global variables PolyBook polybook3 and Polybook polybook4 to polybook.cpp.

Author: massimilianogoi 
Date: Thu Aug 24 11:20:00 2019 +0200 

Added nested if conditions to the condition if (Options["OwnBook"] && !Limits.infinite && !Limits.mate)
so that it checks also the existence of a position on polybook3 and polybook4.

Author: protonspring 
Date: Sat Aug 24 08:21:30 2019 +0200 
Timestamp: 1566627690 

Improve signature of evaluate_shelter() 

Remove one parameter in function evaluate_shelter(), making all 
comparisons for castled/uncastled shelter locally in do_king_safety(). 
Also introduce BlockedStorm penalty. 

Passed non-regression test at STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 65864 W: 14630 L: 14596 D: 36638 Elo +0.18
http://tests.stockfishchess.org/tests/view/5d5fc80c0ebc5939d09f0acc 

No functional change 
 
Author: protonspring 
Date: Fri Aug 23 16:29:29 2019 +0200 
Timestamp: 1566570569 

Consolidate CastlingSide and CastlingRights 

This is a non-functional simplification that removes CastlingSide and 
implements the functionality in CastlingRights (thanks to Jörg Oster 
for a comment on the first version of this patch). 

STC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 53854 W: 12077 L: 12019 D: 29758 Elo +0.37
http://tests.stockfishchess.org/tests/view/5d517b940ebc5925cf107474 

Closes https://github.com/official-stockfish/Stockfish/pull/2265 

No functional change 
 
Author: protonspring 
Date: Fri Aug 23 09:37:12 2019 +0200 
Timestamp: 1566545832 

Simplify futility equation 

This is a functional simplification. The 178 constant for the futility equation 
in master can be removed. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 42626 W: 9508 L: 9428 D: 23690 Elo +0.65
http://tests.stockfishchess.org/tests/view/5d5d4e320ebc5925cf11254e 

LTC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 26182 W: 4432 L: 4320 D: 17430 Elo +1.49
http://tests.stockfishchess.org/tests/view/5d5df70d0ebc5925cf112fee 

Closes https://github.com/official-stockfish/Stockfish/pull/2278 

Bench: 3985701 
 
Author: Vizvezdenec 
Date: Wed Aug 21 10:47:40 2019 +0200 
Timestamp: 1566377260 

Late move reduction, captures and CUT nodes 

Expand of Stefan Geschwentner's original idea: we always do LMR for captures at cutnodes. 

Passed STC 
http://tests.stockfishchess.org/tests/view/5d5b2f8e0ebc5925cf1111b8 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 36026 W: 8122 L: 7779 D: 20125 Elo +3.31

Passed LTC 
http://tests.stockfishchess.org/tests/view/5d5b40c80ebc5925cf111353 
LLR: 3.22 (-2.94,2.94) [0.00,3.50] 
Total: 133502 W: 22508 L: 21943 D: 89051 Elo +1.47

Closes https://github.com/official-stockfish/Stockfish/pull/2273 

Bench: 3494372 
 
Author: protonspring 
Date: Wed Aug 21 09:34:46 2019 +0200 
Timestamp: 1566372886 

Tuned Futility Equation 

@Vizvezdenec array suggested that alternate values may be better than current 
master (see pull request #2270 ). I tuned some linear equations to more closely 
represent his values and it passed. These futility values seem quite sensitive, 
so perhaps additional Elo improvements can be found here. 

STC 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 12257 W: 2820 L: 2595 D: 6842 Elo +6.38
http://tests.stockfishchess.org/tests/view/5d5b2f360ebc5925cf1111ac 

LTC 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 20273 W: 3497 L: 3264 D: 13512 Elo +3.99
http://tests.stockfishchess.org/tests/view/5d5c0d250ebc5925cf111ac3 

Closes https://github.com/official-stockfish/Stockfish/pull/2272 

------------------------------------------ 
How to continue from there ? 

a) we can try a simpler version for the futility margin, this would 
 be a simplification : 
 margin = 188 * (depth - improving) 

b) on the other direction, we can try a complexification by trying 
 again to gain Elo with an complete array of futility values. 

------------------------------------------ 

Bench: 4330402 
 
Author: Jean Gauthier 
Date: Wed Aug 21 09:11:17 2019 +0200 
Timestamp: 1566371477 

Slight speep up fetching the endgame table 

Replace calls to count(key) + operator[key] with a single call to find(key). 
Replace the std::map with std::unordered_map which provide O(1) access, 
although the map has a really small number of objects. 

Test with [0..4] failed yellow: 

TC 10+0.1 
SPRT elo0: 0.00 alpha: 0.05 elo1: 4.00 beta: 0.05 
LLR -2.96 [-2.94,2.94] (rejected) 
Elo 1.01 [-0.87,3.08] (95%) 
LOS 85.3% 
Games 71860 [w:22.3%, l:22.2%, d:55.5%] 
http://tests.stockfishchess.org/tests/view/5d5432210ebc5925cf109d61 

Closes https://github.com/official-stockfish/Stockfish/pull/2269 

No functional change 
 
Author: Alain SAVARD 
Date: Wed Aug 14 22:15:48 2019 +0200 
Timestamp: 1565813748 

Assorted trivial cleanups (July 2019) 

No functional change 
 
Author: Stefan Geschwentner 
Date: Wed Aug 14 20:59:04 2019 +0200 
Timestamp: 1565809144 

Tweak unsafe checks 

Remove mobility area for unsafe checks. Also separate the evaluation terms 
for unsafe checks and blockers for king with adjusted weights. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 124526 W: 28292 L: 27504 D: 68730 Elo +2.20
http://tests.stockfishchess.org/tests/view/5d5138290ebc5925cf1070c3 

LTC: 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 84968 W: 14499 L: 14083 D: 56386 Elo +1.70
http://tests.stockfishchess.org/tests/view/5d527cfa0ebc5925cf107f93 

Bench: 4139590  
