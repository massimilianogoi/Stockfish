Stockfish Polyglot 2019-05-02

Downloaded from https://chess.massimilianogoi.com

GitHub page: https://github.com/massimilianogoi/Stockfish-Polyglot/

For feedbacks or suggestions please write me at https://chess.massimilianogoi.com/contacts/

--------------------------------------

CHANGELOG:

This distribution is the expansion of Stockfish beta having timestamp: 1556390826 - Allow for address sanitizer. (#2119).

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

Stockfish Polyglot 2019-05-02

Binaries:

Windows:

Stockfish_Polyglot_2019-05-02_32bit.exe
Stockfish_Polyglot_2019-05-02_32bit_general.exe
Stockfish_Polyglot_2019-05-02_32bit_old.exe
Stockfish_Polyglot_2019-05-02_32bit_popc.exe
Stockfish_Polyglot_2019-05-02_x64.exe
Stockfish_Polyglot_2019-05-02_x64_bmi2.exe
Stockfish_Polyglot_2019-05-02_x64_general.exe
Stockfish_Polyglot_2019-05-02_x64_modern.exe
Stockfish_Polyglot_2019-05-02_x64_popc.exe

No Linux:, as I'm busy with other projects and I had to delete the Linux virtual machine.


Changes since the last Stockfish Polyglot release:



Author: Joost VandeVondele 
Date: Sat Apr 27 20:47:06 2019 +0200 
Timestamp: 1556390826 

Allow for address sanitizer. (#2119) 

Properly allow for sanitize=address (-fsanitize=address) as an argument to the Makefile. 

No functional change
 
Author: Marco Costalba 
Date: Sat Apr 27 11:37:51 2019 +0200 
Timestamp: 1556357871 

Fix bench number of previous patch 

bench: 3388643 
 
Author: Michael Chaly 
Date: Sat Apr 27 11:31:55 2019 +0200 
Timestamp: 1556357515 

Include bishop protection in king Danger evaluation. #2118 

Same idea as fisherman's knight protection. 

passed STC 
LLR: 2.96 (-2.94,2.94) [0.50,4.50] 
Total: 17133 W: 3952 L: 3701 D: 9480 Elo +5.09
http://tests.stockfishchess.org/tests/view/5cc3550b0ebc5925cf02dada 

passed LTC 
LLR: 2.95 (-2.94,2.94) [0.00,3.50] 
Total: 37316 W: 6470 L: 6188 D: 24658 Elo +2.63
http://tests.stockfishchess.org/tests/view/5cc3721d0ebc5925cf02dc90 

Looking at this 2 ideas being recent clean elo gainers I have a feeling that we can add also rook and queen protection bonuses or overall move this stuff in pieces loop in the same way as we do pieces attacking bonuses on their kingring... :) Thx fisherman for original idea. 

Bench 3429173
 
Author: MJZ1977 
Date: Sat Apr 27 11:25:23 2019 +0200 
Timestamp: 1556357123 

Shuffle detection #2108 

Bench: 3402947  
