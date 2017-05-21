#import "glfw.odin";
#import "gl.odin";

#import "fmt.odin";
#import "math.odin";

main :: proc() {
    // init glfw
    if glfw.Init() == 0 {
        fmt.println("Error initializing GLFW");
        return;
    }

    glfw.WindowHint(glfw.SAMPLES, 4);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3);
    glfw.WindowHint(glfw.OPENGL_PROFILE,glfw. OPENGL_CORE_PROFILE);
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, 1);

    // create window
    title := "blah\x00";
    window := glfw.CreateWindow(1700, 900, ^byte(&title[0]), nil, nil);
    if window == nil {
        fmt.println("Error creating window");
        glfw.Terminate();
        return;
    }

    glfw.MakeContextCurrent(window);
    glfw.SwapInterval(0);

    // load opengl function pointers, using glfw.GetProcAddress
    gl.init( proc(p: rawptr, name: string) { (^(proc() #cc_c))(p)^ = glfw.GetProcAddress(&name[0]); } );

    // main loop
    gl.ClearColor(130.0/255, 140/255.0, 170/255.0, 1.0);
    for glfw.WindowShouldClose(window) == 0 {
        // Set window title based on frame time
        calculate_frame_timings(window);

        glfw.PollEvents();

        // drawing
        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);


        glfw.SwapBuffers(window);
    }

    glfw.Terminate();
}


mousewheel_callback :: proc(window: ^glfw.window, xoffset, yoffset: f64) #cc_c {

    fmt.println(xoffset, yoffset);
}


// globals for timings
_TimingStruct :: struct {
    t1, avg_dt, avg_dt2, last_frame_time : f64,
    num_samples, counter: int
}
persistent_timing_data := _TimingStruct{0.0, 0.0, 0.0, 1.0/60, 60, 0};

calculate_frame_timings :: proc(window: ^glfw.window) {
    using persistent_timing_data;
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


// Minimal Standard LCG
seed : u32 = 12345;
rng :: proc() -> f64 {
    seed *= 16807;
    return f64(seed) / f64(0x100000000);
}
