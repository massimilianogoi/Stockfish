Stockfish Polyglot 2019-04-26

Downloaded from https://chess.massimilianogoi.com

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1556128317 - Remove useless initializations (#2115).

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

Stockfish Polyglot 2019-04-26

Binaries:

Windows:

Stockfish_Polyglot_2019-04-26_32bit.exe
Stockfish_Polyglot_2019-04-26_32bit_general.exe
Stockfish_Polyglot_2019-04-26_32bit_old.exe
Stockfish_Polyglot_2019-04-26_32bit_popc.exe
Stockfish_Polyglot_2019-04-26_x64.exe
Stockfish_Polyglot_2019-04-26_x64_bmi2.exe
Stockfish_Polyglot_2019-04-26_x64_general.exe
Stockfish_Polyglot_2019-04-26_x64_modern.exe
Stockfish_Polyglot_2019-04-26_x64_popc.exe

No Linux:, as I'm busy with other projects and I had to delete the Linux virtual machine.


Changes since the last Stockfish Polyglot release:



Author: Joost VandeVondele 
Date: Wed Apr 24 19:51:57 2019 +0200 
Timestamp: 1556128317 

Remove useless initializations (#2115) 

Removes two unneeded inits, they are always set before their use later on. 

No functional change.
 
Author: protonspring 
Date: Sat Apr 20 08:34:14 2019 +0200 
Timestamp: 1555742054 

Remove DistanceRing #2107 

Remove the DistanceRing array. This reduces the 
memory footprint by about 4kb. 

http://tests.stockfishchess.org/tests/view/5cba35350ebc5925cf020d7f 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 101421 W: 22491 L: 22528 D: 56402 Elo -0.13

No functional change. 
 
Author: Joost VandeVondele 
Date: Fri Apr 19 17:33:26 2019 +0200 
Timestamp: 1555688006 

Remove capping in reduction (#2110) 

Saves two std::min. 

Bench is unchanged to high depth, but in principle this is a functional change so tested both STC and LTC. 

passed STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 78193 W: 17220 L: 17210 D: 43763 Elo +0.04
http://tests.stockfishchess.org/tests/view/5cb789540ebc5925cf01b90b 

passed LTC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 93846 W: 15964 L: 15962 D: 61920 Elo +0.01
http://tests.stockfishchess.org/tests/view/5cb8066d0ebc5925cf01c72b 

Bench: 3402947
 
Author: Joost VandeVondele 
Date: Thu Apr 18 16:53:52 2019 +0200 
Timestamp: 1555599232 

Simplify distance (#2109) 

Only called with Squares as argument, so remove unused variants. 

As this is just syntax changes, only verified bench at high depth. 

No functional change.
 
Author: protonspring 
Date: Wed Apr 17 21:13:39 2019 +0200 
Timestamp: 1555528419 

Remove Movepick::move (#2085) 

The "move" class variable is Movepick is removed (removes some abstraction) which saves a few assignment operations, and the effects of "filter" is limited to the current move (movePtr). The resulting code is a bit more verbose, but it is also more clear what is going on. This version is NOT tested, but is substantially similar to: 

STC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 29191 W: 6474 L: 6367 D: 16350 Elo +1.27
http://tests.stockfishchess.org/tests/view/5ca7aab50ebc5925cf006e50 

This is a non-functional simplification.
 
Author: protonspring 
Date: Tue Apr 16 23:10:53 2019 +0200 
Timestamp: 1555449053 

Move pawnsOnSquares to Position (#2100) 

We can remove the values in Pawns if we just use the piece arrays in Position. This reduces the size of a pawn entry. This simplification passed individually, and in concert with ps_passedcount100 (removes passedCount storage in pawns.). 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 19957 W: 4529 L: 4404 D: 11024 Elo +2.18
http://tests.stockfishchess.org/tests/view/5cb3c2d00ebc5925cf016f0d 

Combo STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 17368 W: 3925 L: 3795 D: 9648 Elo +2.60
http://tests.stockfishchess.org/tests/view/5cb3d3510ebc5925cf01709a 

This is a non-functional simplification.
 
Author: protonspring 
Date: Tue Apr 16 16:12:47 2019 +0200 
Timestamp: 1555423967 

Calculate passedCount real-time #2099 

This is a non-functional simplification which removes the passedCount variable in pawns. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 27982 W: 6227 L: 6118 D: 15637 Elo +1.35
http://tests.stockfishchess.org/tests/view/5cb3cdd30ebc5925cf017025 

Combo STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 17368 W: 3925 L: 3795 D: 9648 Elo +2.60
http://tests.stockfishchess.org/tests/view/5cb3d3510ebc5925cf01709a 

Non functional test.
 
Author: protonspring 
Date: Tue Apr 16 16:09:36 2019 +0200 
Timestamp: 1555423776 

Remove semiopenFiles in pawns and simplify space #2102 

This is a functional simplification. 

 1. semiopenFiles is removed in pawns and uses the piece arrays in position instead. 

 2. popcount is removed in space calculations and uses pawn piece count instead. 

STC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 33327 W: 7423 L: 7324 D: 18580 Elo +1.03
http://tests.stockfishchess.org/tests/view/5cb4be090ebc5925cf018511 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 10173 W: 1774 L: 1636 D: 6763 Elo +4.71
http://tests.stockfishchess.org/tests/view/5cb4c5920ebc5925cf018696 

bench 3402947