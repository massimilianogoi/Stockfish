@echo off

make -f MakeFile profile-build ARCH=x86-32 COMP=mingw 
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 32bit.exe"
make clean
make -f MakeFile profile-build ARCH=general-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 32bit general.exe"
make clean
make -f MakeFile profile-build ARCH=x86-32-sse41-popcnt COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 32bit sse41-ppc.exe"
make clean
make -f MakeFile profile-build ARCH=x86-32-sse2 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 32bit sse2.exe"
make clean
make build ARCH=ppc-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 32bit ppc.exe"
make clean
pause
