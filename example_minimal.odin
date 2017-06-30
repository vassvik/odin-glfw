import (
    "fmt.odin";
    "strings.odin";
    "glfw.odin";
)

// called every time GLFW encounters an error.
error_callback :: proc(error: i32, desc: ^u8) #cc_c {
    fmt.printf("Error code %d:\n    %s\n", error, strings.to_odin_string(desc));
}

main :: proc() {
    // Set error callback, to tell us what's wrong in case it cannot
    // initialize or create a window, or something else entirely.
    glfw.SetErrorCallback(error_callback);

    // Initialize glfw.
    if glfw.Init() == 0 {
        return;
    }

    // Create a 1280x720 window, needs a dummy title.
    title := "blah\x00";
    //defer free(title);
    window := glfw.CreateWindow(1280, 720, &title[0], nil, nil);
    if window == nil {
        glfw.Terminate();
        return;
    }
    defer glfw.Terminate();

    // Minimal main loop.
    for glfw.WindowShouldClose(window) == glfw.FALSE {
        glfw.PollEvents();
        glfw.SwapBuffers(window);
    }
}