/*

 MIT License

 Copyright © 2021-2026 Samuel Venable

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

*/

#include <apiprocess/process.hpp>
#include <apifilesystem/filesystem.hpp>
#if (defined(__apiprocess_supported__) && defined(__apifilesystem_supported__))
#include <iostream>

#include <cctype>
#include <cstdio>
#include <cstddef>
#include <cstring>

#if ((defined(_WIN32) || defined(_WIN64)) && defined(_MSC_VER))
#pragma comment(linker, "/subsystem:console /ENTRY:mainCRTStartup")
#endif
#endif

int main(int argc, char **argv) {
  #if (defined(__apiprocess_supported__) && defined(__apifilesystem_supported__))
  std::string scratch_game;
  if (argc == 2 && argv[1] && strcmp(argv[1], "")) {
    scratch_game = argv[1];
  } else {
    ngs::fs::environment_unset_variable("IMGUI_DIALOG_PARENT");
    ngs::fs::environment_set_variable("IMGUI_DIALOG_WIDTH", std::to_string(720));
    ngs::fs::environment_set_variable("IMGUI_DIALOG_HEIGHT", std::to_string(394));
    ngs::fs::environment_set_variable("IMGUI_DIALOG_THEME", std::to_string(2));
    ngs::fs::environment_set_variable("IMGUI_TEXT_COLOR_0", std::to_string(1));
    ngs::fs::environment_set_variable("IMGUI_TEXT_COLOR_1", std::to_string(1));
    ngs::fs::environment_set_variable("IMGUI_TEXT_COLOR_2", std::to_string(1));
    ngs::fs::environment_set_variable("IMGUI_HEAD_COLOR_0", std::to_string(0.55));
    ngs::fs::environment_set_variable("IMGUI_HEAD_COLOR_1", std::to_string(0.35));
    ngs::fs::environment_set_variable("IMGUI_HEAD_COLOR_2", std::to_string(0.55));
    ngs::fs::environment_set_variable("IMGUI_AREA_COLOR_0", std::to_string(0.18));
    ngs::fs::environment_set_variable("IMGUI_AREA_COLOR_1", std::to_string(0.18));
    ngs::fs::environment_set_variable("IMGUI_AREA_COLOR_2", std::to_string(0.18));
    ngs::fs::environment_set_variable("IMGUI_BODY_COLOR_0", std::to_string(1));
    ngs::fs::environment_set_variable("IMGUI_BODY_COLOR_1", std::to_string(1));
    ngs::fs::environment_set_variable("IMGUI_BODY_COLOR_2", std::to_string(1));
    ngs::fs::environment_set_variable("IMGUI_POPS_COLOR_0", std::to_string(0.07));
    ngs::fs::environment_set_variable("IMGUI_POPS_COLOR_1", std::to_string(0.07));
    ngs::fs::environment_set_variable("IMGUI_POPS_COLOR_2", std::to_string(0.07));
    ngs::fs::environment_set_variable("IMGUI_FONT_SIZE", std::to_string(20));
    #if (defined(_WIN32) || defined(_WIN64))
    ngs::ps::ngs_proc_id_t proc_id = ngs::ps::spawn_child_proc_id(ngs::fs::executable_get_directory() + "CLI\\SDL3-ImGui-FileDialogs\\filedialogs\\filedialogs.exe --get-open-filename-ext \"Scratch Game Files (*.sb3)|*.sb3\" \"\" \"\" \"Select a Scratch *.sb3 Game File to play...\"", true);
    #else
    ngs::ps::ngs_proc_id_t proc_id = ngs::ps::spawn_child_proc_id(ngs::fs::executable_get_directory() + "CLI/SDL2-ImGui-FileDialogs/filedialogs/filedialogs --get-open-filename-ext \"Scratch Game Files (*.sb3)|*.sb3\" \"\" \"\" \"Select a Scratch *.sb3 Game File to play...\"", true);
    #endif 
    scratch_game = ngs::ps::read_from_stdout_for_child_proc_id(proc_id);
    while (!scratch_game.empty() && (scratch_game.back() == '\n' || scratch_game.back() == '\r')) {
      scratch_game.pop_back();
    }
    ngs::ps::free_stdout_for_child_proc_id(proc_id);
    ngs::ps::free_stdin_for_child_proc_id(proc_id);
  }
  if (!scratch_game.empty()) {
    ngs::ps::ngs_proc_id_t proc_id = ngs::ps::spawn_child_proc_id(ngs::fs::executable_get_directory() + "CLI/ScratchEverywhere/scratch-pc \"" + scratch_game + "\"", true);
    ngs::ps::free_stdout_for_child_proc_id(proc_id);
    ngs::ps::free_stdin_for_child_proc_id(proc_id);
  }
  #endif
  return 0;
}
