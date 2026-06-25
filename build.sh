#!/bin/sh
# Some platforms do not accept the -o flag for uname; any warnings printed to the terminal concerning this can be safely ignored...
# SDL2-ImGui-FileDialogs, SDL3-ImGui-FileDialogs, and ScratchEverywhere should *probably* be git submodules instead of this crap...
cd "${0%/*}" && mkdir "CLI";
if [ `uname -o` = "Msys" ]; then
  git clone "https://github.com/samuelvenable/SDL3-ImGui-FileDialogs" "CLI/SDL3-ImGui-FileDialogs";
  cd "CLI/SDL3-ImGui-FileDialogs" && make && cd "../..";
else
  git clone "https://github.com/samuelvenable/SDL2-ImGui-FileDialogs" "CLI/SDL2-ImGui-FileDialogs";
  cd "CLI/SDL2-ImGui-FileDialogs" && make && cd "../..";
fi;
git clone "https://github.com/ScratchEverywhere/ScratchEverywhere" "CLI/ScratchEverywhere";
cd "CLI/ScratchEverywhere" && cmake . && make && cd "../..";
if [ `uname -o` = "Msys" ]; then
  g++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere.exe" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -static -lntdll -lshell32 -lole32 -luuid -Wl,--subsystem,console; "./ScratchEverywhere.exe";
elif [ `uname` = "Darwin" ]; then
  clang++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -mmacos-version-min=10.13 -arch arm64 -arch x86_64; "./ScratchEverywhere";
elif [ `uname -o` = "GNU/Linux" ]; then
  if [ -f "/bin/g++" ]; then
    g++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -lpthread -static; "./ScratchEverywhere";
  else
    clang++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -lpthread; "./ScratchEverywhere";
  fi;
elif [ `uname` = "FreeBSD" ]; then
  clang++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -lelf -lkvm -lpthread -static; "./ScratchEverywhere";
elif [ `uname` = "DragonFly" ]; then
  g++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -lkvm -lpthread -static; "./ScratchEverywhere";
elif [ `uname` = "NetBSD" ]; then
  g++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -lkvm -lpthread -static; "./ScratchEverywhere";
elif [ `uname` = "OpenBSD" ]; then
  clang++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -lkvm -lpthread -static; "./ScratchEverywhere";
elif [ `uname` = "SunOS" ]; then
  if [ `uname -o` = "illumos" ]; then
    g++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -D__illumos__ -Wall -static-libgcc -lkvm -lproc -lpthread; "./ScratchEverywhere";
  else
    g++ "main.cpp" "apifilesystem/filesystem.cpp" "apiprocess/process.cpp" -o "ScratchEverywhere" -I"." -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -lkvm -lproc -lpthread; "./ScratchEverywhere";
  fi;
fi;
