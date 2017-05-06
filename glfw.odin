#foreign_system_library glfw "glfw"         when ODIN_OS == "linux";
#foreign_system_library glfw "glfw3dll.lib" when ODIN_OS == "windows";

/*** Structs ***/
window  :: struct{};
monitor :: struct{};
cursor  :: struct{};

vidmode :: struct {
	width, height:                i32,
	redBits, greenBits, blueBits: i32,
	refreshRate:                  i32
};

gammaramp :: struct {
	red, green, blue: ^u16,
	size:              u32
};

image :: struct {
	width, height:  i32,
	pixels:        ^byte
};

/*** Procedure type declarations ***/
glProc              :: #type proc()                                                  #cc_c;
vkProc              :: #type proc()                                                  #cc_c;

windowposProc       :: #type proc(window: ^window, xpos, ypos: i32)                  #cc_c;
windowsizeProc      :: #type proc(window: ^window, width, height: i32)               #cc_c;
windowcloseProc     :: #type proc(window: ^window)                                   #cc_c;
windowrefreshProc   :: #type proc(window: ^window)                                   #cc_c;
windowfocusProc     :: #type proc(window: ^window, focused: i32)                     #cc_c;
windowiconifyProc   :: #type proc(window: ^window, iconified: i32)                   #cc_c;
monitorProc         :: #type proc(window: ^window)                                   #cc_c;
framebuffersizeProc :: #type proc(window: ^window, width, height: i32)               #cc_c;
dropProc            :: #type proc(window: ^window, count: i32, paths: ^^byte)        #cc_c;

keyProc             :: #type proc(window: ^window, key, scancode, action, mods: i32) #cc_c;
mousebuttonProc     :: #type proc(window: ^window, button, action, mods: i32)        #cc_c;
cursorposProc       :: #type proc(window: ^window, xpos,  ypos: f64)                 #cc_c;
scrollProc          :: #type proc(window: ^window, xoffset, yoffset: f64)            #cc_c;
charProc            :: #type proc(window: ^window, codepoint: u32)                   #cc_c;
charmodsProc        :: #type proc(window: ^window, codepoint: u32, mods: i32)        #cc_c;
cursorenterProc     :: #type proc(window: ^window, entered: i32)                     #cc_c;
joystickProc        :: #type proc(joy, event: i32)                                   #cc_c;

errorProc           :: #type proc(error: i32, description: ^byte)                    #cc_c;

/*** Functions ***/
Init      :: proc() -> int                                                                                    #foreign glfw "glfwInit";
Terminate :: proc()                                                                                           #foreign glfw "glfwTerminate";

GetVersion       :: proc(major, minor, rev: ^i32)                                                             #foreign glfw "glfwGetVersion";
GetVersionString :: proc() -> ^i8                                                                             #foreign glfw "glfwGetVersionString";

GetMonitors            :: proc(count: ^i32) -> ^^monitor                                                      #foreign glfw "glfwGetMonitors";
GetPrimaryMonitor      :: proc() -> ^monitor                                                                  #foreign glfw "glfwGetPrimaryMonitor";
GetMonitorPos          :: proc(monitor: ^monitor, xpos, ypos: ^i32)                                           #foreign glfw "glfwGetMonitorPos";
GetMonitorPhysicalSize :: proc(monitor: ^monitor, widthMM, heightMM: ^i32)                                    #foreign glfw "glfwGetMonitorPhysicalSize";
GetMonitorName         :: proc(monitor: ^monitor) -> ^i8                                                      #foreign glfw "glfwGetMonitorName";

GetVideoModes :: proc(monitor: ^monitor, count: ^i32) -> ^vidmode                                             #foreign glfw "glfwGetVideoModes";
GetVideoMode  :: proc(monitor: ^monitor) -> ^vidmode                                                          #foreign glfw "glfwGetVideoMode";

SetGamma     :: proc(monitor: ^monitor, gamma: f32)                                                           #foreign glfw "glfwSetGamma";
GetGammaRamp :: proc(monitor: ^monitor) -> ^gammaramp                                                         #foreign glfw "glfwGetGammaRamp";
SetGammaRamp :: proc(monitor: ^monitor, ramp: ^gammaramp)                                                     #foreign glfw "glfwSetGammaRamp";

CreateWindow  :: proc(width, height: i32, title: ^byte, monitor: ^monitor, share: ^window) -> ^window         #foreign glfw "glfwCreateWindow";
DestroyWindow :: proc(window: ^window)                                                                        #foreign glfw "glfwDestroyWindow";

WindowHint         :: proc(hint, value: i32)                                                                  #foreign glfw "glfwWindowHint";
DefaultWindowHints :: proc()                                                                                  #foreign glfw "glfwDefaultWindowHints";

WindowShouldClose    :: proc(window: ^window) -> i32                                                          #foreign glfw "glfwWindowShouldClose"; 
SetWindowShouldClose :: proc(window: ^window, value: i32)                                                     #foreign glfw "glfwSetWindowShouldClose"; 

SwapInterval :: proc(interval: i32)                                                                           #foreign glfw "glfwSwapInterval";	
SwapBuffers  :: proc(window: ^window)                                                                         #foreign glfw "glfwSwapBuffers";

SetWindowTitle       :: proc(window: ^window, title: ^byte)                                                   #foreign glfw "glfwSetWindowTitle";
SetWindowIcon        :: proc(window: ^window, count: i32, images: ^image)                                     #foreign glfw "glfwSetWindowIcon";
GetWindowPos         :: proc(window: ^window, xpos, ypos: ^i32)                                               #foreign glfw "glfwGetWindowPos";
SetWindowPos         :: proc(window: ^window, xpos, ypos: i32)                                                #foreign glfw "glfwSetWindowPos";
GetWindowSize        :: proc(window: ^window, width, height: ^i32)                                            #foreign glfw "glfwGetWindowSize";
SetWindowSizeLimits  :: proc(window: ^window, minwidth, minheight, maxwidth, maxheight: i32)                  #foreign glfw "glfwSetWindowSizeLimits";
SetWindowAspectRatio :: proc(window: ^window, numer, denom: i32)                                              #foreign glfw "glfwSetWindowAspectRatio";
SetWindowSize        :: proc(window: ^window, width, height: i32)                                             #foreign glfw "glfwSetWindowSize";
GetFramebufferSize   :: proc(window: ^window, width, height: ^i32)                                            #foreign glfw "glfwGetFramebufferSize";
GetWindowFrameSize   :: proc(window: ^window, left, top, right, bottom: ^i32)                                 #foreign glfw "glfwGetWindowFrameSize";

IconifyWindow  :: proc(window: ^window)                                                                       #foreign glfw "glfwIconifyWindow";
RestoreWindow  :: proc(window: ^window)                                                                       #foreign glfw "glfwRestoreWindow";
MaximizeWindow :: proc(window: ^window)                                                                       #foreign glfw "glfwMaximizeWindow";
ShowWindow     :: proc(window: ^window)                                                                       #foreign glfw "glfwShowWindow";
HideWindow     :: proc(window: ^window)                                                                       #foreign glfw "glfwHideWindow";
FocusWindow    :: proc(window: ^window)                                                                       #foreign glfw "glfwFocusWindow";

GetWindowMonitor     :: proc(window: ^window)                                                                 #foreign glfw "glfwGetWindowMonitor";
SetWindowMonitor     :: proc(window: ^window, monitor: ^monitor, xpos, ypos, width, height, refreshRate: i32) #foreign glfw "glfwSetWindowMonitor";
GetWindowAttrib      :: proc(window: ^window, attrib: i32) -> i32                                             #foreign glfw "glfwGetWindowAttrib";
SetWindowUserPointer :: proc(window: ^window, pointer: rawptr /* void* */)                                    #foreign glfw "glfwSetWindowUserPointer";
GetWindowUserPointer :: proc(window: ^window) -> rawptr                                                       #foreign glfw "glfwGetWindowUserPointer";

PollEvents        :: proc()                                                                                   #foreign glfw "glfwPollEvents";
WaitEvents        :: proc()                                                                                   #foreign glfw "glfwWaitEvents";
WaitEventsTimeout :: proc(timeout: f64)                                                                       #foreign glfw "glfwWaitEventsTimeout";
PostEmptyEvent    :: proc()                                                                                   #foreign glfw "glfwPostEmptyEvent";

GetInputMode :: proc(window: ^window, mode: i32) -> i32                                                       #foreign glfw "glfwGetInputMode";
SetInputMode :: proc(window: ^window, mode, value: i32)                                                       #foreign glfw "glfwSetInputMode";

GetKey         :: proc(window: ^window, key: i32) -> i32                                                      #foreign glfw "glfwGetKey";
GetKeyName     :: proc(key, scancode: i32) -> ^i8                                                             #foreign glfw "glfwGetKeyName";
GetMouseButton :: proc(window: ^window, button: i32) -> i32                                                   #foreign glfw "glfwGetMouseButton";
GetCursorPos   :: proc(window: ^window, xpos, ypos: ^f64)                                                     #foreign glfw "glfwGetCursorPos";

SetCursorPos   :: proc(window: ^window, xpos, ypos: f64)                                                      #foreign glfw "glfwSetCursorPos";

CreateCursor         :: proc(image: ^image, xhot, yhot: i32) -> ^cursor                                       #foreign glfw "glfwCreateCursor";
DestroyCursor        :: proc(cursor: ^cursor)                                                                 #foreign glfw "glfwDestroyCursor";
SetCursor            :: proc(window: ^window, cursor: ^cursor)                                                #foreign glfw "glfwSetCursor";
CreateStandardCursor :: proc(shape: i32) -> ^cursor                                                           #foreign glfw "glfwCreateStandardCursor";

JoystickPresent    :: proc(joy: i32) -> i32                                                                   #foreign glfw "glfwJoystickPresent";
GetJoystickAxes    :: proc(joy: i32, count: ^i32) -> ^f32                                                     #foreign glfw "glfwGetJoystickAxes";
GetJoystickButtons :: proc(joy: i32, count: ^i32) -> ^u8                                                      #foreign glfw "glfwGetJoystickButtons";
GetJoystickName    :: proc(joy: i32) -> ^i8                                                                   #foreign glfw "glfwGetJoystickName";

SetClipboardString :: proc(window: ^window, str: ^i8)                                                         #foreign glfw "glfwSetClipboardString";
GetClipboardString :: proc(window: ^window) -> ^i8                                                            #foreign glfw "glfwGetClipboardString";

GetTime           :: proc() -> f64                                                                            #foreign glfw "glfwGetTime";
SetTime           :: proc(time: f64)                                                                          #foreign glfw "glfwSetTime";
GetTimerValue     :: proc() -> u64                                                                            #foreign glfw "glfwGetTimerValue";
GetTimerFrequency :: proc() -> u64                                                                            #foreign glfw "glfwGetTimerFrequency";

MakeContextCurrent :: proc(window: ^window)                                                                   #foreign glfw "glfwMakeContextCurrent";	
GetCurrentContext  :: proc() -> ^window                                                                       #foreign glfw "glfwGetCurrentContext";
GetProcAddress     :: proc(name : ^byte) -> glProc                                                            #foreign glfw "glfwGetProcAddress";
ExtensionSupported :: proc(extension: ^i8) -> i32                                                             #foreign glfw "glfwExtensionSupported";
VulkanSupported    :: proc() -> i32                                                                           #foreign glfw "glfwVulkanSupported";

GetRequiredInstanceExtensions :: proc(count: ^u32) -> ^^i8                                                    #foreign glfw "glfwGetRequiredInstanceExtensions";

SetMonitorCallback         :: proc(window: ^window, cbfun: monitorProc)                                       #foreign glfw "glfwSetMonitorCallback";
SetFramebuffersizeCallback :: proc(window: ^window, cbfun: framebuffersizeProc)                               #foreign glfw "glfwSetFramebuffersizeCallback";
SetWindowPosCallback       :: proc(window: ^window, cbfun: windowposProc)                                     #foreign glfw "glfwSetWindowPosCallback";
SetWindowSizeCallback      :: proc(window: ^window, cbfun: windowsizeProc)                                    #foreign glfw "glfwSetWindowSizeCallback";
SetWindowCloseCallback     :: proc(window: ^window, cbfun: windowcloseProc)                                   #foreign glfw "glfwSetWindowCloseCallback";
SetWindowRefreshCallback   :: proc(window: ^window, cbfun: windowrefreshProc)                                 #foreign glfw "glfwSetWindowRefreshCallback";
SetWindowFocusCallback     :: proc(window: ^window, cbfun: windowfocusProc)                                   #foreign glfw "glfwSetWindowFocusCallback";
SetWindowIconifyCallback   :: proc(window: ^window, cbfun: windowiconifyProc)                                 #foreign glfw "glfwSetWindowIconifyCallback";
SetDropCallback            :: proc(window: ^window, cbfun: dropProc)                                          #foreign glfw "glfwSetDropCallback";

SetKeyCallback         :: proc(window: ^window, cbfun: keyProc)                                               #foreign glfw "glfwSetKeyCallback";
SetMouseButtonCallback :: proc(window: ^window, cbfun: mousebuttonProc)                                       #foreign glfw "glfwSetMouseButtonCallback";
SetCursorPosCallback   :: proc(window: ^window, cbfun: cursorposProc)                                         #foreign glfw "glfwSetCursorPosCallback";
SetScrollCallback      :: proc(window: ^window, cbfun: scrollProc)                                            #foreign glfw "glfwSetScrollCallback";
SetCharCallback        :: proc(window: ^window, cbfun: charProc)                                              #foreign glfw "glfwSetCharCallback";
SetCharModsCallback    :: proc(window: ^window, cbfun: charmodsProc)                                          #foreign glfw "glfwSetCharModsCallback";
SetCursorEnterCallback :: proc(window: ^window, cbfun: cursorenterProc)                                       #foreign glfw "glfwSetCursorEnterCallback";
SetJoystickCallback    :: proc(window: ^window, cbfun: joystickProc)                                          #foreign glfw "glfwSetJoystickCallback";
    
SetErrorCallback :: proc(window: ^window, cbfun: errorProc)                                                   #foreign glfw "glfwSetErrorCallback";


/*
// Skipping Vulkan for now..
// IF VK_VERSION_1_0?
//GetInstanceProcAddress               :: proc(instance: VkInstance, procname: ^i8)                                                              -> vkProc   #foreign glfw "glfwGetInstanceProcAddress";
//GetPhysicalDevicePresentationSupport :: proc(omstamce: VkInstance, device: VkPhysicalDevice, queuefamily: u32)                                 -> i32      #foreign glfw "glfwGetPhysicalDevicePresentationSupport";
//CreateWindowSurface                  :: proc(instance: VkInstance, window: ^window, allocator: ^VkAllocationCallbacks, surface: ^VkSurfaceKHR) -> VkResult #foreign glfw "glfwCreateWindowSurface";
*/

/*** Constants ***/

/* Versions */
VERSION_MAJOR    :: 3;
VERSION_MINOR    :: 2;
VERSION_REVISION :: 1;

/* Booleans */
TRUE  :: 1;
FALSE :: 0;

/* Button/Key states */
RELEASE :: 0;
PRESS   :: 1;
REPEAT  :: 2;

/* The unknown key */
KEY_UNKNOWN :: -1;

/** Printable keys **/

/* Named printable keys */
KEY_SPACE         :: 32;
KEY_APOSTROPHE    :: 39;  /* ' */
KEY_COMMA         :: 44;  /* , */
KEY_MINUS         :: 45;  /* - */
KEY_PERIOD        :: 46;  /* . */
KEY_SLASH         :: 47;  /* / */
KEY_SEMICOLON     :: 59;  /* ; */
KEY_EQUAL         :: 61;  /* = */
KEY_LEFT_BRACKET  :: 91;  /* [ */
KEY_BACKSLASH     :: 92;  /* \ */
KEY_RIGHT_BRACKET :: 93;  /* ] */
KEY_GRAVE_ACCENT  :: 96;  /* ` */
KEY_WORLD_1       :: 161; /* non-US #1 */
KEY_WORLD_2       :: 162; /* non-US #2 */

/* Alphanumeric characters */
KEY_0 :: 48;
KEY_1 :: 49;
KEY_2 :: 50;
KEY_3 :: 51;
KEY_4 :: 52;
KEY_5 :: 53;
KEY_6 :: 54;
KEY_7 :: 55;
KEY_8 :: 56;
KEY_9 :: 57;

KEY_A :: 65;
KEY_B :: 66;
KEY_C :: 67;
KEY_D :: 68;
KEY_E :: 69;
KEY_F :: 70;
KEY_G :: 71;
KEY_H :: 72;
KEY_I :: 73;
KEY_J :: 74;
KEY_K :: 75;
KEY_L :: 76;
KEY_M :: 77;
KEY_N :: 78;
KEY_O :: 79;
KEY_P :: 80;
KEY_Q :: 81;
KEY_R :: 82;
KEY_S :: 83;
KEY_T :: 84;
KEY_U :: 85;
KEY_V :: 86;
KEY_W :: 87;
KEY_X :: 88;
KEY_Y :: 89;
KEY_Z :: 90;


/** Function keys **/

/* Named non-printable keys */
KEY_ESCAPE       :: 256;
KEY_ENTER        :: 257;
KEY_TAB          :: 258;
KEY_BACKSPACE    :: 259;
KEY_INSERT       :: 260;
KEY_DELETE       :: 261;
KEY_RIGHT        :: 262;
KEY_LEFT         :: 263;
KEY_DOWN         :: 264;
KEY_UP           :: 265;
KEY_PAGE_UP      :: 266;
KEY_PAGE_DOWN    :: 267;
KEY_HOME         :: 268;
KEY_END          :: 269;
KEY_CAPS_LOCK    :: 280;
KEY_SCROLL_LOCK  :: 281;
KEY_NUM_LOCK     :: 282;
KEY_PRINT_SCREEN :: 283;
KEY_PAUSE        :: 284;

/* Function keys */
KEY_F1  :: 290;
KEY_F2  :: 291;
KEY_F3  :: 292;
KEY_F4  :: 293;
KEY_F5  :: 294;
KEY_F6  :: 295;
KEY_F7  :: 296;
KEY_F8  :: 297;
KEY_F9  :: 298;
KEY_F10 :: 299;
KEY_F11 :: 300;
KEY_F12 :: 301;
KEY_F13 :: 302;
KEY_F14 :: 303;
KEY_F15 :: 304;
KEY_F16 :: 305;
KEY_F17 :: 306;
KEY_F18 :: 307;
KEY_F19 :: 308;
KEY_F20 :: 309;
KEY_F21 :: 310;
KEY_F22 :: 311;
KEY_F23 :: 312;
KEY_F24 :: 313;
KEY_F25 :: 314;

/* Keypad numbers */
KEY_KP_0 :: 320;
KEY_KP_1 :: 321;
KEY_KP_2 :: 322;
KEY_KP_3 :: 323;
KEY_KP_4 :: 324;
KEY_KP_5 :: 325;
KEY_KP_6 :: 326;
KEY_KP_7 :: 327;
KEY_KP_8 :: 328;
KEY_KP_9 :: 329;

/* Keypad named function keys */
KEY_KP_DECIMAL  :: 330;
KEY_KP_DIVIDE   :: 331;
KEY_KP_MULTIPLY :: 332;
KEY_KP_SUBTRACT :: 333;
KEY_KP_ADD      :: 334;
KEY_KP_ENTER    :: 335;
KEY_KP_EQUAL    :: 336;

/* Modifier keys */
KEY_LEFT_SHIFT    :: 340;
KEY_LEFT_CONTROL  :: 341;
KEY_LEFT_ALT      :: 342;
KEY_LEFT_SUPER    :: 343;
KEY_RIGHT_SHIFT   :: 344;
KEY_RIGHT_CONTROL :: 345;
KEY_RIGHT_ALT     :: 346;
KEY_RIGHT_SUPER   :: 347;
KEY_MENU          :: 348;

KEY_LAST :: KEY_MENU;

/* Bitmask for modifier keys */
MOD_SHIFT   :: 0x0001;
MOD_CONTROL :: 0x0002;
MOD_ALT     :: 0x0004;
MOD_SUPER   :: 0x0008;

/* Mouse buttons */
MOUSE_BUTTON_1 :: 0;
MOUSE_BUTTON_2 :: 1;
MOUSE_BUTTON_3 :: 2;
MOUSE_BUTTON_4 :: 3;
MOUSE_BUTTON_5 :: 4;
MOUSE_BUTTON_6 :: 5;
MOUSE_BUTTON_7 :: 6;
MOUSE_BUTTON_8 :: 7;

/* Mousebutton aliases */
MOUSE_BUTTON_LAST   :: MOUSE_BUTTON_8;
MOUSE_BUTTON_LEFT   :: MOUSE_BUTTON_1;
MOUSE_BUTTON_RIGHT  :: MOUSE_BUTTON_2;
MOUSE_BUTTON_MIDDLE :: MOUSE_BUTTON_3;

/* Joystick buttons */
JOYSTICK_1  :: 0;
JOYSTICK_2  :: 1;
JOYSTICK_3  :: 2;
JOYSTICK_4  :: 3;
JOYSTICK_5  :: 4;
JOYSTICK_6  :: 5;
JOYSTICK_7  :: 6;
JOYSTICK_8  :: 7;
JOYSTICK_9  :: 8;
JOYSTICK_10 :: 9;
JOYSTICK_11 :: 10;
JOYSTICK_12 :: 11;
JOYSTICK_13 :: 12;
JOYSTICK_14 :: 13;
JOYSTICK_15 :: 14;
JOYSTICK_16 :: 15;

JOYSTICK_LAST :: JOYSTICK_16;

/* Error constants */
NOT_INITIALIZED     :: 0x00010001;
NO_CURRENT_CONTEXT  :: 0x00010002;
INVALID_ENUM        :: 0x00010003;
INVALID_VALUE       :: 0x00010004;
OUT_OF_MEMORY       :: 0x00010005;
API_UNAVAILABLE     :: 0x00010006;
VERSION_UNAVAILABLE :: 0x00010007;
PLATFORM_ERROR      :: 0x00010008;
FORMAT_UNAVAILABLE  :: 0x00010009;
NO_WINDOW_CONTEXT   :: 0x0001000A;

/* Window attributes */
FOCUSED      :: 0x00020001;
ICONIFIED    :: 0x00020002;
RESIZABLE    :: 0x00020003;
VISIBLE      :: 0x00020004;
DECORATED    :: 0x00020005;
AUTO_ICONIFY :: 0x00020006;
FLOATING     :: 0x00020007;
MAXIMIZED    :: 0x00020008;

/* Pixel window attributes */
RED_BITS         :: 0x00021001;
GREEN_BITS       :: 0x00021002;
BLUE_BITS        :: 0x00021003;
ALPHA_BITS       :: 0x00021004;
DEPTH_BITS       :: 0x00021005;
STENCIL_BITS     :: 0x00021006;
ACCUM_RED_BITS   :: 0x00021007;
ACCUM_GREEN_BITS :: 0x00021008;
ACCUM_BLUE_BITS  :: 0x00021009;
ACCUM_ALPHA_BITS :: 0x0002100A;
AUX_BUFFERS      :: 0x0002100B;
STEREO           :: 0x0002100C;
SAMPLES          :: 0x0002100D;
SRGB_CAPABLE     :: 0x0002100E;
REFRESH_RATE     :: 0x0002100F;
DOUBLEBUFFER     :: 0x00021010;

/* Context window attributes */
CLIENT_API               :: 0x00022001;
CONTEXT_VERSION_MAJOR    :: 0x00022002;
CONTEXT_VERSION_MINOR    :: 0x00022003;
CONTEXT_REVISION         :: 0x00022004;
CONTEXT_ROBUSTNESS       :: 0x00022005;
OPENGL_FORWARD_COMPAT    :: 0x00022006;
OPENGL_DEBUG_CONTEXT     :: 0x00022007;
OPENGL_PROFILE           :: 0x00022008;
CONTEXT_RELEASE_BEHAVIOR :: 0x00022009;
CONTEXT_NO_ERROR         :: 0x0002200A;
CONTEXT_CREATION_API     :: 0x0002200B;

/* APIs */
NO_API        :: 0;
OPENGL_API    :: 0x00030001;
OPENGL_ES_API :: 0x00030002;

/* Robustness? */
NO_ROBUSTNESS         :: 0;
NO_RESET_NOTIFICATION :: 0x00031001;
LOSE_CONTEXT_ON_RESET :: 0x00031002;

/* OpenGL Profiles */
OPENGL_ANY_PROFILE    :: 0;
OPENGL_CORE_PROFILE   :: 0x00032001;
OPENGL_COMPAT_PROFILE :: 0x00032002;

/* Cursor draw state and whether keys are sticky */
CURSOR               :: 0x00033001;
STICKY_KEYS          :: 0x00033002;
STICKY_MOUSE_BUTTONS :: 0x00033003;

/* Cursor draw state */
CURSOR_NORMAL   :: 0x00034001;
CURSOR_HIDDEN   :: 0x00034002;
CURSOR_DISABLED :: 0x00034003;

/* Behavior? */
ANY_RELEASE_BEHAVIOR   :: 0;
RELEASE_BEHAVIOR_FLUSH :: 0x00035001;
RELEASE_BEHAVIOR_NONE  :: 0x00035002;

/* Context API ? */
NATIVE_CONTEXT_API :: 0x00036001;
EGL_CONTEXT_API    :: 0x00036002;

/* Types of cursors */
ARROW_CURSOR     :: 0x00036001;
IBEAM_CURSOR     :: 0x00036002;
CROSSHAIR_CURSOR :: 0x00036003;
HAND_CURSOR      :: 0x00036004;
HRESIZE_CURSOR   :: 0x00036005;
VRESIZE_CURSOR   :: 0x00036006;

/* Joystick? */
CONNECTED    :: 0x00040001;
DISCONNECTED :: 0x00040002;

/*  */
DONT_CARE :: -1;