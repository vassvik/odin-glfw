package glfw

// TODO: Unfinished

import "core:os"

when os.OS == .Windows {
	import bind "bindings"

	HWND :: rawptr;

	get_win32_window :: proc(window: Window_Handle) -> HWND {
		return bind.GetWin32Window(window);
	}
}
