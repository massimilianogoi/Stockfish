Stockfish Polyglot 2019-07-28

--------------------------------------

Due to the missing of this feature in the main release I have decided
to create a Stockfish perfectly equal to the last beta version with
the capability to use Polyglot books (aka .bin or BIN).
In order to do that I used the library polyblook.h from Brainfish and
merged with the Stockfish code.

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

LICENSE:

Since this program is under the GPU license you can do whatever you want with it, included
uploading it on other websites, as far as its source is cited (the Stockfish crew,
Thomas Zipproth for Brainfish and me (Massimiliano Goi) for this project).
--------------------------------------

CHANGELOG:

Author: mstembera 
Date: Fri Jul 26 03:33:32 2019 +0200 
Timestamp: 1564104812 

Bug fix: always choose shortest mate in multithread mode 

In current master, with the voting scheme the best thread selection may 
pick a non mate or not the shortest mate thread. This patch fixes this bug. 
Formatting suggestion by Jörg Oster. 

Related past pull requests: 
https://github.com/official-stockfish/Stockfish/pull/1074 
https://github.com/official-stockfish/Stockfish/pull/1215 

Passed a [-4..0] verification test with 3 threads: 
LLR: 2.95 (-2.94,2.94) [-4.00,0.00] 
Total: 57158 W: 11374 L: 11424 D: 34360 Elo -0.30
http://tests.stockfishchess.org/tests/view/5d22deb30ebc5925cf0caefd 

Closes https://github.com/official-stockfish/Stockfish/pull/2226 

No functional change (in single threaded mode) 

---------------------------------------------------- 

Comment by Jörg Oster 

Just one sample output to demonstrate the effect of this patch. 
5 Threads, 1 GB Hash 

 +---+---+---+---+---+---+---+---+ 
 | r | | b | | | r | k | | 
 +---+---+---+---+---+---+---+---+ 
 | | | | n | | p | b | | 
 +---+---+---+---+---+---+---+---+ 
 | | | p | | p | | p | | 
 +---+---+---+---+---+---+---+---+ 
 | p | | | | | | P | | 
 +---+---+---+---+---+---+---+---+ 
 | P | p | | | B | | N | Q | 
 +---+---+---+---+---+---+---+---+ 
 | | q | | | | | P | | 
 +---+---+---+---+---+---+---+---+ 
 | | | R | | | P | | | 
 +---+---+---+---+---+---+---+---+ 
 | | | | R | | | K | | 
 +---+---+---+---+---+---+---+---+ 

Fen: r1b2rk1/3n1pb1/2p1p1p1/p5P1/Pp2B1NQ/1q4P1/2R2P2/3R2K1 w - - 8 34 
Key: 38B4CA1067D4F477 
Checkers: 
ucinewgame 
isready 
readyok 
go mate 17 searchmoves d1d7 
info depth 65 seldepth 36 multipv 1 score mate 18 nodes 785875935 nps 8650448 hashfull 1000 tbhits 0 time 90848 pv d1d7 c8d7 g4f6 g7f6 g5f6 b3a3 g1g2 a3a1 h4g5 a1f6 g5f6 e6e5 c2c1 d7h3 g2h3 a8a6 h3g2 c6c5 f6a6 g8g7 c1c5 f7f6 a6e6 f8f7 c5c8 f6f5 e4d5 g7h6 e6f7 f5f4 f7e7 f4f3 d5f3 b4b3 c8h8 
info depth 63 seldepth 36 multipv 1 score mate 17 nodes 785875935 nps 8650448 hashfull 1000 tbhits 0 time 90848 pv d1d7 c8d7 g4f6 g7f6 g5f6 b3a3 g1g2 a3a1 h4g5 a1f6 g5f6 e6e5 c2c1 d7h3 g2h3 a8a6 c1d1 b4b3 h3g2 c6c5 f6a6 g8g7 d1d7 g7g8 a6f6 b3b2 e4g6 b2b1q g6f7 f8f7 f6f7 g8h8 f7g7 
bestmove d1d7 ponder c8d7 
 
Author: protonspring 
Date: Fri Jul 26 02:12:23 2019 +0200 
Timestamp: 1564099943 

Remove operators for color 

This is a non-functional and untested simplification. The increment operator 
for color isn't really necessary and seems a bit unnatural to me. 

Passed STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 47027 W: 10589 L: 10518 D: 25920 Elo +0.52
http://tests.stockfishchess.org/tests/view/5d3472d10ebc5925cf0e8d3e 

Closes https://github.com/official-stockfish/Stockfish/pull/2247 

No functional change 
 
Author: Vizvezdenec 
Date: Thu Jul 25 09:16:53 2019 +0200 
Timestamp: 1564039013 

Tweak of SEE pruning condition 

passed STC 
http://tests.stockfishchess.org/tests/view/5d386bda0ebc5925cf0ef49a 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 56874 W: 12820 L: 12373 D: 31681 Elo +2.73

passed LTC 
http://tests.stockfishchess.org/tests/view/5d38873a0ebc5925cf0ef86e 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 43512 W: 7547 L: 7247 D: 28718 Elo +2.40

Additional thanks to @locutus2 , @miguel-l and @xoto10 for fruitful discussion. 
There may be some more elo there since this tweak was the first one and numbers 
are more or less arbitrary. 

Closes https://github.com/official-stockfish/Stockfish/pull/2256 

Bench 3935523 
 
Author: Alain SAVARD 
Date: Thu Jul 25 09:05:08 2019 +0200 
Timestamp: 1564038308 

Pawn clean up 

Non functional simplification when we find the passed pawns in pawn.cpp 
and some code clean up. It also better follows the pattern "flag the pawn" 
and "score the pawn". 

------------------------- 

The idea behind the third condition for candidate passed pawn is a little 
bit difficult to visualize. Just for the record, the idea is the following: 

Consider White e5 d4 against black e6. d4 can (in some endgames) push 
to d5 and lever e6. Thanks to this sacrifice, or after d5xe6, we consider 
e5 as "passed". 

However: 
- if White e5/d4 against black e6/c6: d4 cannot safely push to d5 since d5 is double attacked; 
- if White e5/d4 against black e6/d5: d4 cannot safely push to d5 since it is occupied. 

This is exactly what the following expression does: 

``` 
 && (shift<Up>(support) & ~(theirPawns | dblAttackThem))) 
``` 

-------------------------- 

http://tests.stockfishchess.org/tests/view/5d3325bb0ebc5925cf0e6e91 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 124666 W: 27586 L: 27669 D: 69411 Elo -0.23

Closes https://github.com/official-stockfish/Stockfish/pull/2255 

No functional change 
 
Author: VoyagerOne 
Date: Thu Jul 25 08:46:26 2019 +0200 
Timestamp: 1564037186 

LMR Tweak 

Reset statScore to zero if negative and most stats shows >= 0 

STC: 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 23097 W: 5242 L: 4963 D: 12892 Elo +4.20
http://tests.stockfishchess.org/tests/view/5d31dd650ebc5925cf0e598f 

LTC: 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 227597 W: 39013 L: 38191 D: 150393 Elo +1.25
http://tests.stockfishchess.org/tests/view/5d31fcdf0ebc5925cf0e5c13 

Closes https://github.com/official-stockfish/Stockfish/pull/2252 

Bench: 3242229 
 
Author: Alain SAVARD 
Date: Thu Jul 25 08:32:49 2019 +0200 
Timestamp: 1564036369 

Passed file cleanup 

Protonspring had a successful functional simplification that removes the 
PassedFile array using a simple linear equation. 

Merge the additive term S(5, 10) of protonspring passed file simplification 
(pull request https://github.com/official-stockfish/Stockfish/pull/2250) 
into the PassedRank array. This harmless change has a different bench because 
the candidate passer evaluation will always get less compared to #2250, 
as we apply bonus = bonus /2. 

Tested as a non-regression against #2250 

Passed STC 
http://tests.stockfishchess.org/tests/view/5d33427e0ebc5925cf0e6fa2 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 81459 W: 18174 L: 18171 D: 45114 Elo +0.01

Passed LTC 
http://tests.stockfishchess.org/tests/view/5d335c8d0ebc5925cf0e731e 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 18525 W: 3176 L: 3052 D: 12297 Elo +2.33

Closes https://github.com/official-stockfish/Stockfish/pull/2250 
Closes https://github.com/official-stockfish/Stockfish/pull/2251 

Bench: 3859856 
 
Author: Lolligerhans 
Date: Thu Jul 25 08:23:43 2019 +0200 
Timestamp: 1564035823 

No influence on unsafeSquares of passers by pieces 

Remove their pieces from influencing 'unsafeSquares' in passer 
evaluation. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 36421 W: 8170 L: 8078 D: 20173 Elo +0.88
http://tests.stockfishchess.org/tests/view/5d22fc8e0ebc5925cf0cb26e 

LTC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 18927 W: 3253 L: 3129 D: 12545 Elo +2.28
http://tests.stockfishchess.org/tests/view/5d26e2b20ebc5925cf0d3218 

Closes https://github.com/official-stockfish/Stockfish/pull/2248 

Bench: 3285659 
 
Author: Vizvezdenec 
Date: Thu Jul 25 08:17:11 2019 +0200 
Timestamp: 1564035431 

Tweak LMR and killers 

Give extra stat bonus/malus in case of LMR for killers. 

passed STC 
http://tests.stockfishchess.org/tests/view/5d2c8e760ebc5925cf0dcf23 
LLR: 2.95 (-2.94,2.94) [0.50,4.50] 
Total: 67188 W: 15030 L: 14534 D: 37624 Elo +2.56

passed LTC 
http://tests.stockfishchess.org/tests/view/5d2d0ce40ebc5925cf0de115 
LLR: 2.96 (-2.94,2.94) [0.00,3.50] 
Total: 144355 W: 24739 L: 24153 D: 95463 Elo +1.41

Closes https://github.com/official-stockfish/Stockfish/pull/2246 

bench 3723147 
 
Author: Alain SAVARD 
Date: Thu Jul 25 08:07:55 2019 +0200 
Timestamp: 1564034875 

Space Invaders 

Try a more ambitius simplification of the space bonus 

STC http://tests.stockfishchess.org/tests/view/5d2b62c90ebc5925cf0da2a4 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 51299 W: 11320 L: 11257 D: 28722 Elo +0.43

LTC http://tests.stockfishchess.org/tests/view/5d2bac270ebc5925cf0db215 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 49761 W: 8409 L: 8335 D: 33017 Elo +0.52

Closes https://github.com/official-stockfish/Stockfish/pull/2243 

bench: 3395999 
 
Author: Marco Costalba 
Date: Sun Jul 14 15:21:08 2019 +0200 
Timestamp: 1563110468 

Fix bench 

Bench: 3357457 
 
Author: Joost VandeVondele 
Date: Sun Jul 14 14:47:50 2019 +0200 
Timestamp: 1563108470 

UCI_Elo implementation (#2225) 

This exploits the recent fractional Skill Level, and is a result from some discussion in #2221 and the older #758. 

Basically, if UCI_LimitStrength is set, it will internally convert UCI_Elo to a matching fractional Skill Level. 
The Elo estimate is based on games at TC 60+0.6, Hash 64Mb, 8moves_v3.pgn, rated with Ordo, anchored to goldfish1.13 (CCRL 40/4 ~2000). 
Note that this is mostly about internal consistency, the anchoring to CCRL is a bit weak, e.g. within this tournament, 
goldfish and sungorus only have a 200Elo difference, their rating difference on CCRL is 300Elo. 

I propose that we continue to expose 'Skill Level' as an UCI option, for backwards compatibility. 

The result of a tournament under those conditions are given by the following table, where the player name reflects the UCI_Elo. 

 # PLAYER : RATING ERROR POINTS PLAYED (%) CFS(%) 
 1 Elo2837 : 2792.2 50.8 536.5 711 75 100 
 2 Elo2745 : 2739.0 49.0 487.5 711 69 100 
 3 Elo2654 : 2666.4 49.2 418.0 711 59 100 
 4 Elo2562 : 2604.5 38.5 894.5 1383 65 100 
 5 Elo2471 : 2515.2 38.1 651.5 924 71 100 
 6 Elo2380 : 2365.9 35.4 478.5 924 52 100 
 7 Elo2289 : 2290.0 28.0 864.0 1596 54 100 
 8 sungorus1.4 : 2204.9 27.8 680.5 1596 43 60 
 9 Elo2197 : 2201.1 30.1 523.5 924 57 100 
 10 Elo2106 : 2103.8 24.5 730.5 1428 51 100 
 11 Elo2014 : 2030.5 30.3 377.5 756 50 98 
 12 goldfish1.13 : 2000.0 ---- 511.0 1428 36 100 
 13 Elo1923 : 1928.5 30.9 641.5 1260 51 100 
 14 Elo1831 : 1829.0 42.1 370.5 756 49 100 
 15 Elo1740 : 1738.3 42.9 277.5 756 37 100 
 16 Elo1649 : 1625.0 42.1 525.5 1260 42 100 
 17 Elo1558 : 1521.5 49.9 298.0 756 39 100 
 18 Elo1467 : 1471.3 51.3 246.5 756 33 100 
 19 Elo1375 : 1407.1 51.9 183.0 756 24 --- 

It can be observed that all set Elos correspond within the error bars with the observed Ordo rating. 

No functional change
 
Author: protonspring 
Date: Sun Jul 14 14:46:10 2019 +0200 
Timestamp: 1563108370 

Remove std::pow from reduction. (#2234) 

This is a functional simplification that removes the std::pow from reduction. The resulting reduction values are within 1% of master. 

This is a simplification because i believe an fp addition and multiplication is much faster than a call to std::pow() which is historically slow and performance varies widely on different architectures. 

STC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 23471 W: 5245 L: 5127 D: 13099 Elo +1.75
http://tests.stockfishchess.org/tests/view/5d27ac1b0ebc5925cf0d476b 

LTC 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 51533 W: 8736 L: 8665 D: 34132 Elo +0.48
http://tests.stockfishchess.org/tests/view/5d27b74e0ebc5925cf0d493c 

Bench 3765158
 
Author: 31m059 
Date: Sun Jul 14 14:42:30 2019 +0200 
Timestamp: 1563108150 

Just blockSq, not forward file. Bench: 3377831 (#2240) 

This is another functional simplification to Stockfish passed pawn evaluation. 

Stockfish evaluates some pawns which are not yet passed as "candidate" passed pawns, which are given half the bonus of fully passed ones. Prior to this commit, Stockfish considered a passed pawn to be a "candidate" if (a) it would not be a passed pawn if moved one square forward (the blocking square), or (b) there were other pawns (of either color) in front of it on the file. This latter condition used a fairly complicated method, forward_file_bb; here, rather than inspect the entire forward file, we simply re-use the blocking square. As a result, some pawns previously considered "candidates", but which are able to push forward, no longer have their bonus halved. 

Simplification tests passed quickly at both STC and LTC. The results from both tests imply that this simplification is, most likely, additionally a small Elo gain, with a LTC likelihood of superiority of 87 percent. 

STC: 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 12908 W: 2909 L: 2770 D: 7229 Elo +3.74
http://tests.stockfishchess.org/tests/view/5d2a1c880ebc5925cf0d9006 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 20723 W: 3591 L: 3470 D: 13662 Elo +2.03
http://tests.stockfishchess.org/tests/view/5d2a21fd0ebc5925cf0d9118 

Bench: 3377831
 
Author: Michael Chaly 
Date: Sun Jul 14 14:41:28 2019 +0200 
Timestamp: 1563108088 

tviigg. (#2238) 

Current master code made sence when we had 2 types of bonuses for protected path to queen. But it was simplified so we have only one bonus now and code was never cleaned. 
This non-functional simplification removes useless defendedsquares bitboard and removes one bitboard assignment (defendedSquares &= attackedBy[Us][ALL_PIECES] + defendedSquares & blockSq becomes just attackedBy[Us][ALL_PIECES] & blockSq also we never assign defendedSquares = squaresToQueen because we don't need it). 
So should be small non-functional speedup. 
Passed simplification SPRT. 
http://tests.stockfishchess.org/tests/view/5d2966ef0ebc5925cf0d7659 
LLR: 2.95 (-2.94,2.94) [-3.00,1.00] 
Total: 23319 W: 5152 L: 5034 D: 13133 Elo +1.76

bench 3361902
 
Author: 31m059 
Date: Sun Jul 14 14:40:45 2019 +0200 
Timestamp: 1563108045 

Linear formula for w. Bench: 3328507 (#2239) 

In Stockfish, both the middlegame and endgame bonus for a passed pawn are calculated as a product of two factors. The first is k, chosen based on the presence of defended and unsafe squares. The second is w, a quadratic function of the pawn's rank. Both are only applied if the pawn's relative rank is at least RANK_4. 

It does not appear that the complexity of a quadratic function is necessary for w. Here, we replace it with a simpler linear one, which performs equally at both STC and LTC. 

STC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 46814 W: 10386 L: 10314 D: 26114 Elo +0.53
http://tests.stockfishchess.org/tests/view/5d29686e0ebc5925cf0d76a1 

LTC: 
LLR: 2.96 (-2.94,2.94) [-3.00,1.00] 
Total: 82372 W: 13845 L: 13823 D: 54704 Elo +0.09
http://tests.stockfishchess.org/tests/view/5d2980650ebc5925cf0d7bfd 

Bench: 3328507 