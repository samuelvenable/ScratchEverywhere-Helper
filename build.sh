#!/bin/sh
# Some platforms do not accept the -o flag for uname; any warnings printed to the terminal concerning this can be safely ignored...
cd "${0%/*}" && mkdir "CLI";
if [ `uname -o` = "Msys" ]; then
  git clone "https://github.com/samuelvenable/SDL3-ImGui-FileDialogs" "CLI/ImFileDialog";
else
  git clone "https://github.com/samuelvenable/SDL2-ImGui-FileDialogs" "CLI/ImFileDialog";
fi;
git clone "https://github.com/ScratchEverywhere/ScratchEverywhere" "CLI/ScratchEverywhere";
cd "CLI/ImFileDialog" && make && cd ../.. && cd "CLI/ScratchEverywhere" && cmake . && make && cd ../..;
if [ `uname -o` = "Msys" ]; then
  g++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc.exe -I. -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -static -lntdll -lshell32 -lole32 -luuid -Wl,--subsystem,console; ./xproc.exe;
elif [ `uname` = "Darwin" ]; then
  clang++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -mmacos-version-min=10.13 -arch arm64 -arch x86_64; ./xproc;
elif [ `uname -o` = "GNU/Linux" ]; then
  if [ -f "/bin/g++" ]; then
    g++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -lpthread -static; ./xproc;
  else
    clang++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -lpthread; ./xproc;
  fi;
elif [ `uname` = "FreeBSD" ]; then
  clang++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -lelf -lkvm -lpthread -static; ./xproc;
elif [ `uname` = "DragonFly" ]; then
  g++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -lkvm -lpthread -static; ./xproc;
elif [ `uname` = "NetBSD" ]; then
  g++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -static-libstdc++ -lkvm -lpthread -static; ./xproc;
elif [ `uname` = "OpenBSD" ]; then
  clang++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -lkvm -lpthread -static; ./xproc;
elif [ `uname` = "SunOS" ]; then
  if [ `uname -o` = "illumos" ]; then
    g++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -D__illumos__ -Wall -static-libgcc -lkvm -lproc -lpthread; ./xproc;
  else
    g++ main.cpp apifilesystem/filesystem.cpp apiprocess/process.cpp -o xproc -I. -std=c++17 -DNULLIFY_STDERR -Wall -static-libgcc -lkvm -lproc -lpthread; ./xproc;
  fi;
fi;
