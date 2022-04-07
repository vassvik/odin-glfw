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

when os.OS == .Darwin {
	import bind "bindings";

	import NS "vendor:darwin/Foundation";

	get_cocoa_monitor :: #force_inline proc(monitor: Monitor_Handle) -> rawptr {
		return bind.GetCocoaMonitor(monitor);
	}
	get_cocoa_window  :: #force_inline proc(window: Window_Handle) -> ^NS.Window {
		return bind.GetCocoaWindow(window);
	}
	get_nsgl_context  :: #force_inline proc(window: Window_Handle) -> rawptr {
		return bind.GetNSGLContext(window);
	}
}
