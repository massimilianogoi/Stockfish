@echo off

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
make profile-build ARCH=x86-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish_Polyglot_%mydate%_32bit.exe"
make clean
make profile-build ARCH=x86-32-old COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish_Polyglot_%mydate%_32bit_old.exe"
make clean
make profile-build ARCH=general-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish_Polyglot_%mydate%_32bit_general.exe"
make clean
make profile-build ARCH=ppc-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish_Polyglot_%mydate%_32bit_popc.exe"
make clean
pause