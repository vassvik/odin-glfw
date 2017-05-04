#import "glfw.odin";
#import "gl.odin";
#import mv_ef "mv_easy_font.odin";

#import "fmt.odin";
#import "math.odin";


// Minimal Standard LCG
seed : u32 = 12345;
rng :: proc() -> f64 {
    seed *= 16807;
    return f64(seed) / f64(0x100000000);
}

main :: proc() {
    // init glfw and create window
    window, status_glfw := init_glfw("Test\x00");
    if !status_glfw {
        return;
    }

    // load opengl function pointers
    gl.init();

    // Optionally load shaders manually
    //success := mv_ef.init("extra/font_vertex_shader.vs", "extra/font_fragment_shader.fs");
    
    num := 15121; // draw 15121 characters simultaneously

    // random colors, there are currently up to 9 colors to choose from
    col := make([]u8, num);
    defer free(col);
    for i in 0..<num {
        col[i] = u8(i % 9);
    }

    // allocate room from characters
    str := make([]u8, num);
    defer free(str);

    // main loop
    gl.ClearColor(3.0/255, 72/255.0, 133/255.0, 1.0);
    for glfw.WindowShouldClose(window) == 0 {
        // Set window title based on frame time
        calculate_frame_timings(window);
        
        // events
        glfw.PollEvents();
        if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
            glfw.SetWindowShouldClose(window, 1);
        }

        // drawing
        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);

        // update string with random characters per position, cycles 10 characters per second
        seed = 12345;

        for i in 0..<num {
            if i % 240 == 0 && i != 0 {
                str[i] = '\n';
            } else {
                str[i] = 32 + (u8((96+128)*rng() + 10.0*glfw.GetTime()) % 224);
            }
        }

        // actual drawing
        mv_ef.draw(str, col, 0.0, 0.0, 12.0);

        glfw.SwapBuffers(window);
    }

    glfw.Terminate();
}


init_glfw :: proc(title: string) -> (^glfw.window, bool) {
    using glfw;

    if Init() == 0 {
        fmt.println("Error initializing GLFW");
        return nil, false;
    }

    WindowHint(SAMPLES, 4);
    WindowHint(CONTEXT_VERSION_MAJOR, 3);
    WindowHint(CONTEXT_VERSION_MINOR, 3);
    WindowHint(OPENGL_PROFILE, OPENGL_CORE_PROFILE);
    WindowHint(OPENGL_FORWARD_COMPAT, 1);
    window_ := CreateWindow(1600, 900, ^byte(&title[0]), nil, nil);
    if window_ == nil {
        fmt.println("Error creating window");
        Terminate();
        return nil, false;
    }

    MakeContextCurrent(window_);
    SwapInterval(0);

    SetKeyCallback(window_, key_callback);
    return window_, true;
}

key_callback :: proc(window: ^glfw.window, key, scancode, action, mods: i32) #cc_c {
    fmt.printf("Key %d %s\n", key, action == glfw.RELEASE ? "pressed" : "released");
}


// globals for timings
t1 := 0.0;
avg_dt := 0.0;
avg_dt2 := 0.0;
num_samples := 60;
counter := 0;
last_frame_time := 1.0/60.0;

calculate_frame_timings :: proc(window: ^glfw.window) {
    t2 := glfw.GetTime();
    dt := t2-t1;
    t1 = t2;

    avg_dt += dt;
    avg_dt2 += dt*dt;
    counter++;

    last_frame_time = dt;

    if counter == num_samples {
        avg_dt  /= f64(num_samples);
        avg_dt2 /= f64(num_samples);
        std_dt := math.sqrt(avg_dt2 - avg_dt*avg_dt);
        ste_dt := std_dt/math.sqrt(f64(num_samples));

        // avg: frame time average over num_samples frames
        // std: standard deviation calculated over those frames
        // ste: standard error (standard deviation of the average) calculated over those frames
        
        title := fmt.aprintf("dt: avg = %.3fms, std = %.3fms, ste = %.4fms. fps = %.1f\x00", 1000.0*avg_dt, 1000.0*std_dt, 1000.0*ste_dt, 1.0/avg_dt);
        defer free(title);

        glfw.SetWindowTitle(window, &title[0]);
        
        num_samples = int(1.0/avg_dt);
        
        avg_dt = 0.0;
        avg_dt2 = 0.0;
        counter = 0;
    }
}