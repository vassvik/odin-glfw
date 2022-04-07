package glfw_bindings 

// TODO: Unfinished

import "core:os"

when os.OS == .Windows {
	foreign import glfw { "../lib/glfw3.lib", "system:user32.lib", "system:gdi32.lib", "system:shell32.lib" };
	
	HWND :: rawptr;

	@(default_calling_convention="c", link_prefix="glfw")
	foreign glfw {
	    GetWin32Window :: proc(window: Window_Handle) -> HWND ---;
	}
}

when os.OS == .Darwin {
	import NS "vendor:darwin/Foundation";

	foreign import glfw { "../lib/libglfw3-osx.a" }

	@(default_calling_convention="c", link_prefix="glfw")
	foreign glfw {
		GetCocoaMonitor :: proc(monitor: Monitor_Handle) -> rawptr ---
		GetCocoaWindow  :: proc(window: Window_Handle) -> ^NS.Window ---
		GetNSGLContext  :: proc(window: Window_Handle) -> rawptr ---
	}
}
