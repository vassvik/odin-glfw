#import "fmt.odin";
#import "strings.odin";
#import "glfw.odin";

error_callback :: proc(error: i32, desc: ^byte) #cc_c {
    fmt.println(strings.to_odin_string(desc));
}

main :: proc() {
    // Set error callback, to tell us what's wrong in case it cannot
    // initialize or create a window, or something else entirely.
    glfw.SetErrorCallback(error_callback);

    // Initialize glfw.
    if glfw.Init() == 0 {
        fmt.println("Error: Could not initialize GLFW.");
        return;
    }

    // Create a 1280x720 window, needs a dummy title.
    title := "blah\x00";
    window := glfw.CreateWindow(1280, 720, ^byte(&title[0]), nil, nil);
    if window == nil {
        fmt.println("Error: Could not create window.");
        glfw.Terminate();
        return;
    }

    // Minimal main loop.
    for glfw.WindowShouldClose(window) == glfw.FALSE {
        glfw.PollEvents();
        glfw.SwapBuffers(window);
    }

    // Clean up.
    glfw.Terminate();
}