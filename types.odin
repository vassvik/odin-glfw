package glfw

import bind "bindings"

/*** Structs/types ***/
Window_Handle  :: bind.Window_Handle;
Monitor_Handle :: bind.Monitor_Handle;
Cursor_Handle  :: bind.Cursor_Handle;

Vid_Mode      :: bind.Vid_Mode;
Gamma_Ramp    :: bind.Gamma_Ramp;
Image         :: bind.Image;
Gamepad_State :: bind.Gamepad_State;

/*  */
Window_Iconify_Proc       :: bind.Window_Iconify_Proc;
Window_Refresh_Proc       :: bind.Window_Refresh_Proc;
Window_Focus_Proc         :: bind.Window_Focus_Proc;
Window_Close_Proc         :: bind.Window_Close_Proc;
Window_Size_Proc          :: bind.Window_Size_Proc;
Window_Pos_Proc           :: bind.Window_Pos_Proc;
Window_Maximize_Proc      :: bind.Window_Maximize_Proc;
Window_Content_Scale_Proc :: bind.Window_Content_Scale_Proc;
Framebuffer_Size_Proc     :: bind.Framebuffer_Size_Proc;
Drop_Proc                 :: bind.Drop_Proc;
Monitor_Proc              :: bind.Monitor_Proc;

Key_Proc          :: bind.Key_Proc;
Mouse_Button_Proc :: bind.Mouse_Button_Proc;
Cursor_Pos_Proc   :: bind.Cursor_Pos_Proc;
Scroll_Proc       :: bind.Scroll_Proc;
Char_Proc         :: bind.Char_Proc;
Char_Mods_Proc    :: bind.Char_Mods_Proc;
Cursor_Enter_Proc :: bind.Cursor_Enter_Proc;
Joystick_Proc     :: bind.Joystick_Proc;

Error_Proc :: bind.Error_Proc;