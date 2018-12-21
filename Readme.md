Stockfish Polyglot is none but the very own Stockfish with the only addition of the possibility to use Polyglot (.bin) books. In order to do that I used the library polybook.h and the C++ file polybook.cpp from Brainfish adding them to the Stockfish code with few other changes to make the polybook functions working. No functional changes to the original Stockfish algorythms were made.
Stockfish Polyglot features also the 'OwnBook' checkbox, so that the user can easily switch from the Polyglot book to the local CTG book (Chessbase softwares) or ABK book (Arena GUI). I've wandered through GitHub to recover the 'OwnBook' checkbox code (it needed just two mere rows..), luckily I've managed to find it and extract the part I needed to use.

### Terms of use

Stockfish is free, and distributed under the **GNU General Public License**
(GPL). Essentially, this means that you are free to do almost exactly
what you want with the program, including distributing it among your
friends, making it available for download from your web site, selling
it (either by itself or as part of some bigger software package), or
using it as the starting point for a software project of your own.

The only real limitation is that whenever you distribute Stockfish in
some way, you must always include the full source code, or a pointer
to where the source code can be found. If you make any changes to the
source code, these changes must also be made available under the GPL.

For full details, read the copy of the GPL found in the file named
*Copying.txt*.
