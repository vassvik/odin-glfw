package glfw

import "core:os"

when os.OS == "linux"   do foreign import glfw "system:glfw"; // TODO: Add the billion-or-so static libs to link to in linux
when os.OS == "windows" do foreign import glfw { "lib/glfw3.lib", "system:user32.lib", "system:gdi32.lib", "system:shell32.lib" };

when os.OS == "windows" {
	HWND :: rawptr;

	@(default_calling_convention="c")
	foreign glfw {
	    @(link_name="glfwGetWin32Window") GetWin32Window :: proc(window: Window_Handle) -> HWND ---;
	}
}
