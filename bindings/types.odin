package glfw_bindings 

Window_Handle  :: distinct rawptr;
Monitor_Handle :: distinct rawptr;
Cursor_Handle  :: distinct rawptr;

Vid_Mode :: struct {
    width:        i32,
    height:       i32,
    red_bits:     i32,
    green_bits:   i32,
    blue_bits:    i32,
    refresh_rate: i32,
};

Gamma_Ramp :: struct {
    red, green, blue: ^u16,
    size:              u32, 
};

Image :: struct {
    width, height: i32,
    pixels:        ^u8,
};

Gamepad_State :: struct {
    buttons: [15]u8,
    axes: [6]f32,
};

/*** Procedure type declarations ***/
Window_Iconify_Proc       :: #type proc "c" (window: Window_Handle, iconified: i32);
Window_Refresh_Proc       :: #type proc "c" (window: Window_Handle);
Window_Focus_Proc         :: #type proc "c" (window: Window_Handle, focused: i32);
Window_Close_Proc         :: #type proc "c" (window: Window_Handle);
Window_Size_Proc          :: #type proc "c" (window: Window_Handle, width, height: i32);
Window_Pos_Proc           :: #type proc "c" (window: Window_Handle, xpos, ypos: i32);
Window_Maximize_Proc      :: #type proc "c" (window: Window_Handle, iconified: i32); 
Window_Content_Scale_Proc :: #type proc "c" (window: Window_Handle, xscale, yscale: f32);
Framebuffer_Size_Proc     :: #type proc "c" (window: Window_Handle, width, height: i32);
Drop_Proc                 :: #type proc "c" (window: Window_Handle, count: i32, paths: ^cstring);
Monitor_Proc              :: #type proc "c" (window: Window_Handle);

Key_Proc          :: #type proc "c" (window: Window_Handle, key, scancode, action, mods: i32);
Mouse_Button_Proc :: #type proc "c" (window: Window_Handle, button, action, mods: i32);
Cursor_Pos_Proc   :: #type proc "c" (window: Window_Handle, xpos,  ypos: f64);
Scroll_Proc       :: #type proc "c" (window: Window_Handle, xoffset, yoffset: f64);
Char_Proc         :: #type proc "c" (window: Window_Handle, codepoint: rune);
Char_Mods_Proc    :: #type proc "c" (window: Window_Handle, codepoint: rune, mods: i32);
Cursor_Enter_Proc :: #type proc "c" (window: Window_Handle, entered: i32);
Joystick_Proc     :: #type proc "c" (joy, event: i32);

Error_Proc            :: #type proc "c" (error: i32, description: cstring);
