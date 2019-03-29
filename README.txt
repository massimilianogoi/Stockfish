Stockfish Polyglot 2019-03-29

Downloaded from https://chess.massimilianogoi.com

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1553445685 - Simplify pawn asymmetry (remove use of semiopen files). (#2054)

Maximize its strength by purchasing my opening book Goi: https://chess.massimilianogoi.com/shop/goiopeningbook/

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

Stockfish Polyglot 2019-03-29

Binaries:

Windows:

Stockfish_Polyglot_2019-03-29_32bit.exe
Stockfish_Polyglot_2019-03-29_32bit_general.exe
Stockfish_Polyglot_2019-03-29_32bit_old.exe
Stockfish_Polyglot_2019-03-29_32bit_popc.exe
Stockfish_Polyglot_2019-03-29_x64.exe
Stockfish_Polyglot_2019-03-29_x64_bmi2.exe
Stockfish_Polyglot_2019-03-29_x64_general.exe
Stockfish_Polyglot_2019-03-29_x64_modern.exe
Stockfish_Polyglot_2019-03-29_x64_popc.exe

This time no Linux:, as I'm busy with other projects and I had to delete the Linux virtual machine.


Changes since the last Stockfish Polyglot release:

Timestamp: 1553445685 

Simplify pawn asymmetry (remove use of semiopen files). (#2054) 

This is a functional simplification. 

To me, the exclusive OR of semiopenFiles here is quite convoluted. Looks like it can be removed. 

STC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 43885 W: 9731 L: 9653 D: 24501 Elo +0.62
http://tests.stockfishchess.org/tests/view/5c9041680ebc5925cfff10ea 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 68437 W: 11577 L: 11533 D: 45327 Elo +0.22
http://tests.stockfishchess.org/tests/view/5c9101740ebc5925cfff1cbf 

bench 3575627
 
Author: Joost VandeVondele 
Date: Sun Mar 24 17:40:29 2019 +0100 
Timestamp: 1553445629 

Remove unneeded condition. (#2057) 

This is covered by the line just before. If we would like to protect 
against the piece value of e.g. a N == B, this could be done by an 
assert, no need to do this at runtime. 

No functional change.
 
Author: protonspring 
Date: Sun Mar 24 17:37:38 2019 +0100 
Timestamp: 1553445458 

Simplify Passed Pawns (#2058) 

This is a non-functional simplification/speedup. 

The truth-table for popcount(support) >= popcount(lever) - 1 is: 
------------------lever 
------------------0-------1---------2 
support--0------X-------X---------0 
-----------1------X-------X---------X 
-----------2------X-------X---------X 

Thus, it is functionally equivalent to just do: support || !more_than_one(lever) which removes the expensive popcounts and the -1. 

Result of 20 runs: 
base (...h_master.exe) = 1451680 +/- 8202 
test (./stockfish ) = 1454781 +/- 8604 
diff = +3101 +/- 931 

STC 
LLR: 2.94 (-2.94,2.94) [-3.00,1.00] 
Total: 35424 W: 7768 L: 7674 D: 19982 Elo +0.92
Http://tests.stockfishchess.org/tests/view/5c970f170ebc5925cfff5e28 

No functional change. 
 
Author: xoto10 
Date: Wed Mar 20 14:57:34 2019 +0100 
Timestamp: 1553090254 

Remove !extension check #2045 

While looking at pruning using see_ge() (which is very valuable) 
it became apparent that the !extension test is not adding any 
value - simplify it away. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 56843 W: 12621 L: 12569 D: 31653 Elo +0.32
http://tests.stockfishchess.org/tests/view/5c8588cb0ebc5925cffe77f4 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 78622 W: 13223 L: 13195 D: 52204 Elo +0.12
http://tests.stockfishchess.org/tests/view/5c8611cc0ebc5925cffe7f86 

Further work could be to optimize the remaining see_ge() test. The idea of less pruning at higher depths is valuable, but perhaps the test (-PawnValueEg * depth) can be improved. 

Bench: 3188688 
 
Author: CoffeeOne 
Date: Wed Mar 20 14:50:41 2019 +0100 
Timestamp: 1553089841 

Skip skipping thread scheme (#1972) 


Several simplification tests (all with the bounds [-3,1]) were run: 
5+0.05 8 threads, failed very quickly: 
http://tests.stockfishchess.org/tests/view/5c439a020ebc5902bb5d3970 

20+0.2 8 threads, also failed, but needed a lot more games: 
http://tests.stockfishchess.org/tests/view/5c44b1b70ebc5902bb5d4e34 

60+0.6 8 threads passed: 
http://tests.stockfishchess.org/tests/view/5c48bfe40ebc5902bca15325 

60+0.6 4 threads passed: 
http://tests.stockfishchess.org/tests/view/5c4b71a00ebc593af5d49904 

No functional change. 
 
Author: Marco Costalba 
Date: Tue Mar 12 08:35:10 2019 +0100 
Timestamp: 1552376110 

Increase thread stack for OS X (#2035) 

On OS X threads other than the main thread are created with a reduced stack 
size of 512KB by default, this is dangerously low for deep searches, so 
adjust it to TH_STACK_SIZE. The implementation calls pthread_create() with 
proper stack size parameter. 

Verified for no regression at STC enabling the patch on all platforms where 
pthread is supported. 

LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 50873 W: 9768 L: 9700 D: 31405 Elo +0.46

No functional change.
 
Author: protonspring 
Date: Sun Mar 10 10:53:39 2019 +0100 
Timestamp: 1552211619 

Remove popcount16() (#2038) 

This is a non-functional simplification / code-style change. 

This popcount16 method does nothing but initialize the PopCnt16 arrays. 

This can be done in a single bitset line, which is less lines and more clear. Performance for this code is moot. 

No functional change.
 
Author: xoto10 
Date: Sun Mar 10 10:47:42 2019 +0100 
Timestamp: 1552211262 

Simplify failedLow away #1986 

FailedLow doesn't seem to add any value so remove it. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 43915 W: 9682 L: 9604 D: 24629 Elo +0.62
http://tests.stockfishchess.org/tests/view/5c5339770ebc592fc7baef74 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 58515 W: 9670 L: 9609 D: 39236 Elo +0.36
http://tests.stockfishchess.org/tests/view/5c53cc840ebc592fc7baf6c1 

Ideas for further work: 

 Tune the values in the revised fallingEval calculation 
 Consider adding a term using delta, e.g. c * (delta - 20) as an indicator of eval instability 

Bench: 3318033 
 
Author: Marco Costalba 
Date: Sat Mar 9 13:28:11 2019 +0100 
Timestamp: 1552134491 

Revert "Allowing singular extension in mate positions" 

It was causing an assert: value > -VALUE_INFINITE 
under some conditions. 

See https://github.com/official-stockfish/Stockfish/issues/2036 

Bench: 3318033  
