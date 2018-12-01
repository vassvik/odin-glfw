package glfw

// TODO: Unfinished

import "core:os"

when os.OS == "windows" {
	import bind "bindings"

	foreign import glfw { "../lib/glfw3.lib", "system:user32.lib", "system:gdi32.lib", "system:shell32.lib" };
	HWND :: rawptr;

	get_win32_window :: proc(window: Window_Handle) -> HWND {
		return bind.GetWin32Window(window);
	}
}
