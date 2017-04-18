#foreign_system_library glfw "glfw"         when ODIN_OS == "linux";
#foreign_system_library glfw "glfw3dll.lib" when ODIN_OS == "windows";

window  :: struct{};
monitor :: struct{};

Proc  :: #type proc() #cc_c; // ?

GetProcAddress :: proc(name : ^byte) -> Proc #foreign glfw "glfwGetProcAddress";

Init                 :: proc() -> int                                                                         #foreign glfw "glfwInit";
Terminate            :: proc()                                                                                #foreign glfw "glfwTerminate";
CreateWindow         :: proc(width, height: i32, title: ^byte, monitor: ^monitor, share: ^window) -> ^window  #foreign glfw "glfwCreateWindow";
WindowShouldClose    :: proc(window: ^window) -> i32                                                          #foreign glfw "glfwWindowShouldClose"; 
SetWindowShouldClose :: proc(window: ^window, value: i32)                                                     #foreign glfw "glfwSetWindowShouldClose"; 
GetKey               :: proc(window: ^window, key: i32) -> i32                                                #foreign glfw "glfwGetKey";
PollEvents           :: proc()                                                                                #foreign glfw "glfwPollEvents";
SwapInterval         :: proc(interval: i32)                                                                   #foreign glfw "glfwSwapInterval";
SwapBuffers          :: proc(window: ^window)                                                                 #foreign glfw "glfwSwapBuffers";
MakeContextCurrent   :: proc(window: ^window)                                                                 #foreign glfw "glfwMakeContextCurrent";	

SetWindowTitle :: proc(window: ^window, title: ^byte) #foreign glfw "glfwSetWindowTitle";

WindowHint           :: proc(hint, value: i32)                                                                #foreign glfw "glfwWindowHint";
GetTime :: proc() -> f64 #foreign glfw "glfwGetTime";




RELEASE :: 0;
PRESS :: 1;
REPEAT :: 2;

SAMPLES :: 0x0002100D;
CONTEXT_VERSION_MAJOR :: 0x00022002;
CONTEXT_VERSION_MINOR :: 0x00022003;
OPENGL_PROFILE :: 0x00022008;
OPENGL_CORE_PROFILE :: 0x00032001;
OPENGL_FORWARD_COMPAT :: 0x00022006;


KEY_ESCAPE :: 256;