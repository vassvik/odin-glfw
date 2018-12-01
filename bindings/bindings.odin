package glfw_bindings 

import "core:os"

when os.OS == "linux"   do foreign import glfw "system:glfw"; // TODO: Add the billion-or-so static libs to link to in linux
when os.OS == "windows" do foreign import glfw { "../lib/glfw3.lib", "system:user32.lib", "system:gdi32.lib", "system:shell32.lib" };

/*** Functions ***/
@(default_calling_convention="c", link_prefix="glfw")
foreign glfw {
    Init      :: proc() -> i32 ---;
    Terminate :: proc() ---;
    
    InitHint  :: proc(hint, value: i32) ---;

    GetVersion :: proc(major, minor, rev: ^i32) ---;
    GetError   :: proc(description: ^cstring) -> i32 ---;

    GetPrimaryMonitor      :: proc() -> Monitor_Handle ---;
    GetMonitors            :: proc(count: ^i32) -> ^Monitor_Handle ---;
    GetMonitorPos          :: proc(monitor: Monitor_Handle, xpos, ypos: ^i32) ---;
    GetMonitorPhysicalSize :: proc(monitor: Monitor_Handle, widthMM, heightMM: ^i32) ---;
    GetMonitorContentScale :: proc(monitor: Monitor_Handle, xscale, yscale: ^f32) ---;

    SetMonitorUserPointer :: proc(monitor: Monitor_Handle, pointer: rawptr) ---;
    GetMonitorUserPointer :: proc(monitor: Monitor_Handle) -> rawptr ---;

    GetVideoMode :: proc(monitor: Monitor_Handle) -> ^Vid_Mode ---;
    SetGamma     :: proc(monitor: Monitor_Handle, gamma: f32) ---;
    GetGammaRamp :: proc(monitor: Monitor_Handle) -> ^Gamma_Ramp ---;
    SetGammaRamp :: proc(monitor: Monitor_Handle, ramp: ^Gamma_Ramp) ---;

    CreateWindow  :: proc(width, height: i32, title: cstring, monitor: Monitor_Handle, share: Window_Handle) -> Window_Handle ---;
    DestroyWindow :: proc(window: Window_Handle) ---;

    WindowHint         :: proc(hint, value: i32) ---;
    DefaultWindowHints :: proc() ---;
    WindowHintString   :: proc(hint: i32, value: cstring) ---;
    WindowShouldClose  :: proc(window: Window_Handle) -> i32 ---;

    SwapInterval :: proc(interval: i32) ---;
    SwapBuffers  :: proc(window: Window_Handle) ---;

    SetWindowTitle       :: proc(window: Window_Handle, title: cstring) ---;
    SetWindowIcon        :: proc(window: Window_Handle, count: i32, images: ^Image) ---;
    SetWindowPos         :: proc(window: Window_Handle, xpos, ypos: i32) ---;
    SetWindowSizeLimits  :: proc(window: Window_Handle, minwidth, minheight, maxwidth, maxheight: i32) ---;
    SetWindowAspectRatio :: proc(window: Window_Handle, numer, denom: i32) ---;
    SetWindowSize        :: proc(window: Window_Handle, width, height: i32) ---;
    GetWindowPos         :: proc(window: Window_Handle, xpos, ypos: ^i32) ---;
    GetWindowSize        :: proc(window: Window_Handle, width, height: ^i32) ---;
    GetFramebufferSize   :: proc(window: Window_Handle, width, height: ^i32) ---;
    GetWindowFrameSize   :: proc(window: Window_Handle, left, top, right, bottom: ^i32) ---;

    GetWindowContentScale :: proc(window: Window_Handle, xscale, yscale: ^f32) ---;
    GetWindowOpacity      :: proc(window: Window_Handle) -> f32 ---;
    SetWindowOpacity      :: proc(window: Window_Handle, opacity: f32) ---;

    GetVersionString     :: proc() -> cstring ---;
    GetMonitorName       :: proc(monitor: Monitor_Handle) -> cstring ---;
    GetClipboardString   :: proc(window: Window_Handle) -> cstring ---;
    GetVideoModes        :: proc(monitor: Monitor_Handle, count: ^i32) -> ^Vid_Mode ---;
    GetKey               :: proc(window: Window_Handle, key: i32) -> i32 ---;
    GetKeyName           :: proc(key, scancode: i32) -> cstring ---;
    SetWindowShouldClose :: proc(window: Window_Handle, value: i32) ---;
    JoystickPresent      :: proc(joy: i32) -> i32 ---;
    VulkanSupported      :: proc() -> i32 ---;
    GetJoystickName      :: proc(joy: i32) -> cstring ---;
    GetKeyScancode       :: proc(key: i32) -> i32 ---;

    IconifyWindow  :: proc(window: Window_Handle) ---;
    RestoreWindow  :: proc(window: Window_Handle) ---;
    MaximizeWindow :: proc(window: Window_Handle) ---;
    ShowWindow     :: proc(window: Window_Handle) ---;
    HideWindow     :: proc(window: Window_Handle) ---;
    FocusWindow    :: proc(window: Window_Handle) ---;

    RequestWindowAttention :: proc(window: Window_Handle) ---;

    GetWindowMonitor     :: proc(window: Window_Handle) -> Monitor_Handle ---;
    SetWindowMonitor     :: proc(window: Window_Handle, monitor: Monitor_Handle, xpos, ypos, width, height, refresh_rate: i32) ---;
    GetWindowAttrib      :: proc(window: Window_Handle, attrib: i32) -> i32 ---;
    SetWindowUserPointer :: proc(window: Window_Handle, pointer: rawptr) ---;
    GetWindowUserPointer :: proc(window: Window_Handle) -> rawptr ---;

    SetWindowAttrib :: proc(window: Window_Handle, attrib, value: i32) ---;

    PollEvents        :: proc() ---;
    WaitEvents        :: proc() ---;
    WaitEventsTimeout :: proc(timeout: f64) ---;
    PostEmptyEvent    :: proc() ---;

    GetInputMode :: proc(window: Window_Handle, mode: i32) -> i32 ---;
    SetInputMode :: proc(window: Window_Handle, mode, value: i32) ---;

    GetMouseButton :: proc(window: Window_Handle, button: i32) -> i32 ---;
    GetCursorPos   :: proc(window: Window_Handle, xpos, ypos: ^f64) ---;
    SetCursorPos   :: proc(window: Window_Handle, xpos, ypos: f64) ---;

    CreateCursor         :: proc(image: ^Image, xhot, yhot: i32) -> Cursor_Handle ---;
    DestroyCursor        :: proc(cursor: Cursor_Handle) ---;
    SetCursor            :: proc(window: Window_Handle, cursor: Cursor_Handle) ---;
    CreateStandardCursor :: proc(shape: i32) -> Cursor_Handle ---;

    GetJoystickAxes        :: proc(joy: i32, count: ^i32) -> ^f32 ---;
    GetJoystickButtons     :: proc(joy: i32, count: ^i32) -> ^u8 ---;
    GetJoystickHats        :: proc(jid: i32, count: ^i32) -> ^u8 ---;
    GetJoystickGUID        :: proc(jid: i32) -> cstring ---;
    SetJoystickUserPointer :: proc(jid: i32, pointer: rawptr) ---;
    GetJoystickUserPointer :: proc(jid: i32) -> rawptr ---;
    JoystickIsGamepad      :: proc(jid: i32) -> i32 ---;
    UpdateGamepadMappings  :: proc(str: cstring) -> i32 ---;
    GetGamepadName         :: proc(jid: i32) -> cstring ---;
    GetGamepadState        :: proc(jid: i32, state: ^Gamepad_State) -> i32 ---;

    SetClipboardString :: proc(window: Window_Handle, str: cstring) ---;

    GetTime           :: proc() -> f64 ---;
    SetTime           :: proc(time: f64) ---;
    GetTimerValue     :: proc() -> u64 ---;
    GetTimerFrequency :: proc() -> u64 ---;

    MakeContextCurrent :: proc(window: Window_Handle) ---;
    GetCurrentContext  :: proc() -> Window_Handle ---;
    GetProcAddress     :: proc(name : cstring) -> rawptr ---;
    ExtensionSupported :: proc(extension: cstring) -> i32 ---;

    GetRequiredInstanceExtensions ::  proc(count: ^u32) -> ^cstring ---;

    SetWindowIconifyCallback      :: proc(window: Window_Handle, cbfun: Window_Iconify_Proc) -> Window_Iconify_Proc ---;
    SetWindowRefreshCallback      :: proc(window: Window_Handle, cbfun: Window_Refresh_Proc) -> Window_Refresh_Proc ---;
    SetWindowFocusCallback        :: proc(window: Window_Handle, cbfun: Window_Focus_Proc) -> Window_Focus_Proc ---;
    SetWindowCloseCallback        :: proc(window: Window_Handle, cbfun: Window_Close_Proc) -> Window_Close_Proc ---;
    SetWindowSizeCallback         :: proc(window: Window_Handle, cbfun: Window_Size_Proc) -> Window_Size_Proc ---;
    SetWindowPosCallback          :: proc(window: Window_Handle, cbfun: Window_Pos_Proc) -> Window_Pos_Proc ---;
    SetFramebufferSizeCallback    :: proc(window: Window_Handle, cbfun: Framebuffer_Size_Proc) -> Framebuffer_Size_Proc ---;
    SetDropCallback               :: proc(window: Window_Handle, cbfun: Drop_Proc) -> Drop_Proc ---;
    SetMonitorCallback            :: proc(window: Window_Handle, cbfun: Monitor_Proc) -> Monitor_Proc ---;
    SetWindowMaximizeCallback     :: proc(window: Window_Handle, cbfun: Window_Maximize_Proc) -> Window_Maximize_Proc ---;
    SetWindowContentScaleCallback :: proc(window: Window_Handle, cbfun: Window_Content_Scale_Proc) -> Window_Content_Scale_Proc ---;

    SetKeyCallback         :: proc(window: Window_Handle, cbfun: Key_Proc) -> Key_Proc ---;
    SetMouseButtonCallback :: proc(window: Window_Handle, cbfun: Mouse_Button_Proc) -> Mouse_Button_Proc ---;
    SetCursorPosCallback   :: proc(window: Window_Handle, cbfun: Cursor_Pos_Proc) -> Cursor_Pos_Proc ---;
    SetScrollCallback      :: proc(window: Window_Handle, cbfun: Scroll_Proc) -> Scroll_Proc ---;
    SetCharCallback        :: proc(window: Window_Handle, cbfun: Char_Proc) -> Char_Proc ---;
    SetCharModsCallback    :: proc(window: Window_Handle, cbfun: Char_Mods_Proc) -> Char_Mods_Proc ---;
    SetCursorEnterCallback :: proc(window: Window_Handle, cbfun: Cursor_Enter_Proc) -> Cursor_Enter_Proc ---;
    SetJoystickCallback    :: proc(window: Window_Handle, cbfun: Joystick_Proc) -> Joystick_Proc ---;

    SetErrorCallback :: proc(cbfun: Error_Proc) -> Error_Proc ---;
    
}

