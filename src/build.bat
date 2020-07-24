@echo off

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
mingw32-make profile-build ARCH=x86-64 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% x64.exe"
make clean
mingw32-make profile-build ARCH=general-64 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% x64 general.exe"
make clean
mingw32-make profile-build ARCH=x86-64-modern COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% x64 modern.exe"
make clean
mingw32-make profile-build ARCH=x86-64-bmi2 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% x64 BMI2.exe"
mingw32-make profile-build ARCH=ppc-64 COMP=mingw CXX=x86_64-w64-mingw32-g++ -j14
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% x64 ppc.exe"
make clean
mingw32-make -f MakeFile profile-build ARCH=x86-32 COMP=mingw 
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% 32bit.exe"
make clean
mingw32-make -f MakeFile profile-build ARCH=x86-32-old COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% 32bit old.exe"
make clean
mingw32-make -f MakeFile profile-build ARCH=general-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% 32bit general.exe"
make clean
mingw32-make build ARCH=ppc-32 COMP=mingw
strip "stockfish_polyglot.exe"
move "stockfish_polyglot.exe" ..\
rename ..\"stockfish_polyglot.exe" "Stockfish Polyglot %mydate% 32bit ppc.exe"
make clean
pause
