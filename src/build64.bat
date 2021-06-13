@echo off

make profile-build ARCH=x86-64 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 x64.exe"
make clean
make profile-build ARCH=x86-64-bmi2 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 x64 BMI2.exe"
make clean
make profile-build ARCH=x86-64-avx2 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 x64 AVX2.exe"
make clean
make profile-build ARCH=general-64 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 x64 general.exe"
make clean
make profile-build ARCH=x86-64-modern COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 x64 modern.exe"
make clean
make profile-build ARCH=ppc-64 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot 13 x64 ppc.exe"
make clean
pause
