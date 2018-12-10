package glfw_bindings 

// TODO: Unfinished

import "core:os"

when os.OS == "windows" {
	foreign import glfw { "../lib/glfw3.lib", "system:user32.lib", "system:gdi32.lib", "system:shell32.lib" };
	
	HWND :: rawptr;

	@(default_calling_convention="c", link_prefix="glfw")
	foreign glfw {
	    GetWin32Window :: proc(window: Window_Handle) -> HWND ---;
	}
}
