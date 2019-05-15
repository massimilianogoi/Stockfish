Stockfish Polyglot 2019-05-15

Downloaded from https://chess.massimilianogoi.com

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1557912187 - Update failedHighCnt rule #2063.

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

Stockfish Polyglot 2019-05-15

Binaries:

Windows:

Stockfish_Polyglot_2019-05-15_32bit.exe
Stockfish_Polyglot_2019-05-15_32bit_general.exe
Stockfish_Polyglot_2019-05-15_32bit_old.exe
Stockfish_Polyglot_2019-05-15_32bit_popc.exe
Stockfish_Polyglot_2019-05-15_x64.exe
Stockfish_Polyglot_2019-05-15_x64_bmi2.exe
Stockfish_Polyglot_2019-05-15_x64_general.exe
Stockfish_Polyglot_2019-05-15_x64_modern.exe
Stockfish_Polyglot_2019-05-15_x64_popc.exe

No Linux:, as I'm busy with other projects and I had to delete the Linux virtual machine.


Changes since the last Stockfish Polyglot release:

Author: xoto10 
Date: Wed May 15 11:23:07 2019 +0200 
Timestamp: 1557912187 

Update failedHighCnt rule #2063 

Treat all threads the same as main thread and increment 
failedHighCnt on fail highs. This makes the search try 
again at lower depth. 

@vondele suggested also changing the reset of failedHighCnt 
when there is a fail low. Tests including this passed so the 
branch has been updated to include both changes. failedHighCnt 
is now handled exactly the same in helper threads and the main 
thread. Thanks vondele :-) 

STC @ 5+0.05 th 4 : 
LLR: 2.94 (-2.94,2.94) [-3.00,1.00] 
Total: 7769 W: 1704 L: 1557 D: 4508 Elo +6.57
http://tests.stockfishchess.org/tests/view/5c9f19520ebc5925cfffd2a1 

LTC @ 20+0.2 th 8 : 
LLR: 2.94 (-2.94,2.94) [-3.00,1.00] 
Total: 37888 W: 5983 L: 5889 D: 26016 Elo +0.86
http://tests.stockfishchess.org/tests/view/5c9f57d10ebc5925cfffd696 

Bench 3824325 
 
Author: Marco Costalba 
Date: Wed May 15 10:52:15 2019 +0200 
Timestamp: 1557910335 

Revert "Make rootDepth local to search. (#2077)" 

This reverts commit 44c320a572188b5875291103edb344c584b91d19. 

Fix a compile error. 

Bench: 3824325 
 
Author: protonspring 
Date: Wed May 15 10:31:21 2019 +0200 
Timestamp: 1557909081 

Simplify connected #2114 

This is a functional simplification that simplifies 
some of the math for connected pawns. The bench is 
different because I moved a /2 from opposed into 
the connected array. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 37954 W: 8504 L: 8415 D: 21035 Elo +0.81
http://tests.stockfishchess.org/tests/view/5cbf599a0ebc5925cf028156 

LTC 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 27780 W: 4682 L: 4572 D: 18526 Elo +1.38
http://tests.stockfishchess.org/tests/view/5cbf6a5e0ebc5925cf0284b8 

Bench 3824325 
 
Author: Moez Jellouli 
Date: Wed May 15 10:26:32 2019 +0200 
Timestamp: 1557908792 

Simplify reduction formula #2122 

Simplify reduction formula 

No functional change. 
 
Author: protonspring 
Date: Wed May 15 10:24:00 2019 +0200 
Timestamp: 1557908640 

Simplify Thread Voting Scheme #2129 

This is a functional simplification of the math in the voting scheme. 

It took a bit longer to pass LTC 8 threads, so perhaps more testing is needed at longer times and/or more threads. 

STC 4 threads 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 22315 W: 4852 L: 4732 D: 12731 Elo +1.87
http://tests.stockfishchess.org/tests/view/5ccc86280ebc5925cf03d439 

STC 8 threads 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 42427 W: 8451 L: 8369 D: 25607 Elo +0.67
http://tests.stockfishchess.org/tests/view/5cccb67c0ebc5925cf03da90 

LTC 4 Threads 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 23513 W: 4208 L: 4092 D: 15213 Elo +1.71
http://tests.stockfishchess.org/tests/view/5ccce94d0ebc5925cf03e1ec 

LTC 8 Threads 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 70098 W: 11442 L: 11399 D: 47257 Elo +0.21
http://tests.stockfishchess.org/tests/view/5ccd22aa0ebc5925cf03e463 

No functional change (in single thread)
 
Author: svivanov72 
Date: Wed May 15 10:22:21 2019 +0200 
Timestamp: 1557908541 

Precompute repetition info (#2132) 

Store repetition info in StateInfo instead of recomputing it in 
three different places. This saves some work in has_game_cycle() 
where this info is needed for positions before the root. 

Tested for non-regression at STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 34104 W: 7586 L: 7489 D: 19029 Elo +0.99
http://tests.stockfishchess.org/tests/view/5cd0676e0ebc5925cf044b56 

No functional change.
 
Author: xoto10 
Date: Wed May 15 10:18:49 2019 +0200 
Timestamp: 1557908329 

Remove pawn count in space() calculation #2139 

Simplification. Various attempts to optimise the pawn 
count bonus showed little effect, so remove pawn count 
altogether and compensate by subtracting 1 instead of 4. 

STC 10+0.1 th 1: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 152244 W: 33709 L: 33847 D: 84688 Elo -0.31
http://tests.stockfishchess.org/tests/view/5cceed330ebc5925cf04170e 

LTC 60+0.6 th 1: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 24100 W: 4079 L: 3964 D: 16057 Elo +1.66
http://tests.stockfishchess.org/tests/view/5cd5b6b80ebc5925cf04e889 

Bench: 3648841 
 
Author: xoto10 
Date: Wed May 15 10:12:38 2019 +0200 
Timestamp: 1557907958 

Add eg component to evaluate_shelter() #2137 

Add an endgame component to the blockedstorm penalty 
so that the penalty applies more uniformly through the game. 

STC 10+0.1 th 1 : 
LLR: -2.95 (-2.94,2.94) [0.50,4.50] 
Total: 94063 W: 21426 L: 21118 D: 51519 Elo +1.14
http://tests.stockfishchess.org/tests/view/5cd4605c0ebc5925cf04bf43 

LTC 60+0.6 th 1 : 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 188232 W: 32808 L: 32090 D: 123334 Elo +1.33
http://tests.stockfishchess.org/tests/view/5cd47d0a0ebc5925cf04c4fd 

Refactored code with higher constant values gave a more convincing LTC result: 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 30050 W: 5330 L: 5066 D: 19654 Elo +3.05
http://tests.stockfishchess.org/tests/view/5cd6a0000ebc5925cf050653 

Bench: 3687700 
 
Author: Joost VandeVondele 
Date: Wed May 15 09:52:27 2019 +0200 
Timestamp: 1557906747 

Allow for higher depths. (#2147) 

High rootDepths, selDepths and generally searches are increasingly 
common with long time control games, analysis, and improving hardware. 
In this case, depths of MAX_DEPTH/MAX_PLY (128) can be reached, 
and the search tree is truncated. 

In principle MAX_PLY can be easily increased, except for a technicality 
of storing depths in a signed 8 bit int in the TT. This patch increases 
MAX_PLY by storing the depth in an unsigned 8 bit, after shifting by the 
most negative depth stored in TT (DEPTH_NONE). 

No regression at STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 42235 W: 9565 L: 9484 D: 23186 Elo +0.67
http://tests.stockfishchess.org/tests/view/5cdb35360ebc5925cf0595e1 

Verified to reach high depths on 
k1b5/1p1p4/pP1Pp3/K2pPp2/1P1p1P2/3P1P2/5P2/8 w - - 
info depth 142 seldepth 154 multipv 1 score cp 537 nodes 26740713110 ... 

No bench change.
 
Author: Michael Chaly 
Date: Wed May 15 09:49:29 2019 +0200 
Timestamp: 1557906569 

Decrease reduction in case we had singular extension. #2146 

Passed STC http://tests.stockfishchess.org/tests/view/5cda71790ebc5925cf057a84 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 73454 W: 16482 L: 15954 D: 41018 Elo +2.50

Passed LTC http://tests.stockfishchess.org/tests/view/5cdab17b0ebc5925cf05822f 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 56696 W: 9877 L: 9538 D: 37281 Elo +2.08

Original idea by @locutus2 

bench 3378510
 
Author: Miguel Lahoz 
Date: Thu May 9 18:00:58 2019 +0200 
Timestamp: 1557417658 

Remove PvNode template from reduction 

This functional simplification removes the PvNode reduction and adjusts 
the ttPv lmr condition accordingly. Their definitions only differ by the 
inclusions of ttPv. Aside from this, shallow move pruning definition 
will be the only other functional difference, but this does not seem to 
matter too much. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 58908 W: 12980 L: 12932 D: 32996 Elo +0.28
http://tests.stockfishchess.org/tests/view/5cd1aaaa0ebc5925cf046c6a 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 20351 W: 3521 L: 3399 D: 13431 Elo +2.08
http://tests.stockfishchess.org/tests/view/5cd23fa70ebc5925cf047cd2 

Bench: 3687854 
 
Author: Sergei Ivanov 
Date: Thu May 9 15:39:57 2019 +0200 
Timestamp: 1557409197 

Fix cycle detection in presence of repetitions 

In master search() may incorrectly return a draw score in the following 
corner case: there was a 2-fold repetition during the game, and the 
current position can be reached by a move from a repeated one. This case 
is treated as an upcoming 3-fold repetition, which it is not. 

Here is a testcase demonstrating the issue (note that the moves 
after FEN are required). The input: 

 position fen 8/8/8/8/8/8/p7/2k4K b - - 0 1 moves c1b1 h1g1 b1c1 g1h1 c1b1 h1g1 b1a1 g1h1 
 go movetime 1000 

produces the output: 

 [...] 
 info depth 127 seldepth 2 multipv 1 score cp 0 [...] 
 bestmove a1b1 

saying that the game will be drawn by repetion. However the other possible 
move for black, Kb2, avoids repetitions and wins. The patch fixes this behavior. 
In particular it finds mate in 10 in the above position. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 10604 W: 2390 L: 2247 D: 5967 Elo +4.69
http://tests.stockfishchess.org/tests/view/5cb373e00ebc5925cf0167bf 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 19620 W: 3308 L: 3185 D: 13127 Elo +2.18
http://tests.stockfishchess.org/tests/view/5cb3822f0ebc5925cf016b2d 

Bench is not changed since it does not test positions with history of moves. 

Bench: 3184182 
 
Author: Stefan Geschwentner 
Date: Thu May 9 15:25:39 2019 +0200 
Timestamp: 1557408339 

Less LMR at root 

Do no LMR for the first four moves if at root node. 

STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 19686 W: 4524 L: 4261 D: 10901 Elo +4.64
http://tests.stockfishchess.org/tests/view/5cd3577b0ebc5925cf04a089 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 88335 W: 15193 L: 14766 D: 58376 Elo +1.68
http://tests.stockfishchess.org/tests/view/5cd35e600ebc5925cf04a1c3 

Bench: 3184182 
 
Author: Stefan Geschwentner 
Date: Sun May 5 23:18:17 2019 +0200 
Timestamp: 1557091097 

LMR for captures not cracking alpha 

Enable LMR for a capture/promotion move which does not seem 
to have a good chance to fail high according to static eval 
and value of captured piece. 

STC: 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 40477 W: 9158 L: 8792 D: 22527 Elo +3.14
http://tests.stockfishchess.org/tests/view/5cceedc60ebc5925cf04174f 

LTC: 
LLR: 2.94 (-2.94,2.94) [0.00,3.50] 
Total: 21926 W: 3873 L: 3634 D: 14419 Elo +3.79
http://tests.stockfishchess.org/tests/view/5ccf04310ebc5925cf041ab0 

Bench: 3644175 
 
Author: VoyagerOne 
Date: Sat May 4 13:41:53 2019 +0200 
Timestamp: 1556970113 

Stat Score reset at rootNode - Bench: 3393330 (#2124) 

At rootNode reset great great grandchildren stat score i.e (ss + 4)->statScore = 0 

STC: (yellow) 
LLR: -2.96 (-2.94,2.94) [0.50,4.50] 
Total: 256079 W: 57423 L: 56315 D: 142341 Elo +1.50
http://tests.stockfishchess.org/tests/view/5ccb0c420ebc5925cf03a6a5 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 61550 W: 10611 L: 10260 D: 40679 Elo +1.98
http://tests.stockfishchess.org/tests/view/5ccbf9d00ebc5925cf03c487 

Bench: 3393330
 
Author: Marco Costalba 
Date: Thu May 2 19:30:26 2019 +0200 
Timestamp: 1556818226 

Assorted trivial cleanups 4/2019 

No functional change. 
 
Author: Joost VandeVondele 
Date: Thu May 2 19:22:29 2019 +0200 
Timestamp: 1556817749 

Simplified shuffle extension version (#2121) 

only the extension part of the shuffle patch is sufficient to 
pass [0,3.5] bounds at VLTC as shown by two more tests. 

http://tests.stockfishchess.org/tests/view/5cc168bc0ebc5925cf02bda8 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 120684 W: 17875 L: 17400 D: 85409 Elo +1.37

http://tests.stockfishchess.org/tests/view/5cc14d510ebc5925cf02bcb5 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 68415 W: 10250 L: 9905 D: 48260 Elo +1.75

this patch proposes to simplify back to this basic and easier to 
understand version. In case there is a need to run a [-3, 1] VLTC on 
this one, it can be done, but it is resource intensive, and not needed 
IMO. 

Bench: 3388643 
