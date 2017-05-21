#import "glfw.odin";

#import "fmt.odin";
#import "math.odin";

main :: proc() {
    // init glfw
    if glfw.Init() == 0 {
        fmt.println("Error: Could not initialize GLFW.");
        return;
    }

    // create window, needs a dummy title
    title := "blah\x00";
    window := glfw.CreateWindow(1270, 720, ^byte(&title[0]), nil, nil);
    if window == nil {
        fmt.println("Error: Could not create window.");
        glfw.Terminate();
        return;
    }

    glfw.SwapInterval(0);

    // main loop
    for glfw.WindowShouldClose(window) == 0 {
        calculate_frame_timings(window);

        glfw.PollEvents();
        if glfw.GetKey(window, glfw.KEY_ESCAPE) == glfw.PRESS {
            glfw.SetWindowShouldClose(window, glfw.TRUE);
        }

        glfw.SwapBuffers(window);
    }

    glfw.Terminate();
}



// Bonus, calculate fps

// globals for persistent timing data, placeholder for "static" variables
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
