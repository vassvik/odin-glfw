#import "glfw.odin";
#import "gl.odin";
#import mv_ef "mv_easy_font.odin";

#import "fmt.odin";
#import "math.odin";

pos64 :: raw_union {
    data: [2]f64,
    using _ : struct {
        x, y: f64
    }
}

io: struct {
    mousewheel_delta: pos64,
    mousewheel:       pos64,
    
    mousepos_delta:      pos64,
    mousepos:            pos64,
    mousepos_last_click: [5]pos64,

    mousebuttons:          [5]int,
    time_last_mouse_click: [5]f64,

    using _: raw_union {
        mods: [4]bool,
        using _: struct { mod_ctrl, mod_shift, mod_alt, mod_meta: bool },
    },

    keys:                [glfw.KEY_LAST]int,
    time_last_key_press: [glfw.KEY_LAST]f64,
};

double_click_time :: 0.5;
double_click_deadzone :: 10.0;
global_mousewheel_deltas: [2]f64; // --__--

update_input :: proc(window: ^glfw.window) {
    // block to isolate bug below..
    {
        using io;

        x, y: f64;
        glfw.GetCursorPos(window, &x, &y);
        current_time := glfw.GetTime();

        for i in 0..<5 {
            new_state := int(glfw.GetMouseButton(window, i32(i)));
            old_state := mousebuttons[i] & 1;
            mousebuttons[i] = new_state | ( (old_state != new_state ? 1 : 0) << 1 );

            // check for double click
            // @TODO: Make only one button double-clickable at a time?, 
            //        such that if a different key is pressed within 
            //        the double click time, it will reset
            if ((mousebuttons[i] & 3) == 3 && current_time - time_last_mouse_click[i] < double_click_time 
                                              && abs(mousepos_last_click[i].x - x) < double_click_deadzone
                                              && abs(mousepos_last_click[i].y - y) < double_click_deadzone) {
                mousebuttons[i] |= 4;
            } else {
                mousebuttons[i] &= ~4;
            }

            // reset double click info
            if ((mousebuttons[i]&3) == 3) {
                time_last_mouse_click[i] = current_time;

                mousepos_last_click[i].x = x;
                mousepos_last_click[i].y = y;
            }
        }

        // mouse position
        mousepos_delta.x = x - mousepos.x;
        mousepos_delta.y = y - mousepos.y;
        mousepos.x = x;
        mousepos.y = y;

        // mouse wheel, from callback BLEH
        mousewheel_delta.x = global_mousewheel_deltas[0];
        mousewheel_delta.y = global_mousewheel_deltas[1];
        mousewheel.x += global_mousewheel_deltas[0];
        mousewheel.y += global_mousewheel_deltas[1];

        for i in ' '..<glfw.KEY_LAST {
            new_state := int(glfw.GetKey(window, i32(i)));
            old_state := keys[i] & 1;
            keys[i] = new_state | ( (old_state != new_state ? 1 : 0) << 1 );

            // double tap
            if ((keys[i] & 3) == 3 && current_time - time_last_key_press[i] < double_click_time) {
                keys[i] |= 4;
            } else {
                keys[i] &= ~4;
            }

            // pressed
            if ((keys[i]&3) == 3) {
                time_last_key_press[i] = current_time;
            }
        }
    }

    // @BUG: HERE BE TROUBLE. Adding io. to any of the mod variables, 
    // or to any of the keys makes it *not* segfault, 
    // otherwise it returns with error code -11.

    // The code above this line works just fine using "using".
    using io;

    mod_ctrl  = (keys[glfw.KEY_LEFT_CONTROL] & 1 == 1) || (keys[glfw.KEY_RIGHT_CONTROL] & 1 == 1);
    mod_shift = (keys[glfw.KEY_LEFT_SHIFT]   & 1 == 1) || (keys[glfw.KEY_RIGHT_SHIFT]   & 1 == 1);
    mod_alt   = (keys[glfw.KEY_LEFT_ALT]     & 1 == 1) || (keys[glfw.KEY_RIGHT_ALT]     & 1 == 1);
    mod_meta  = (keys[glfw.KEY_LEFT_SUPER]   & 1 == 1) || (keys[glfw.KEY_RIGHT_SUPER]   & 1 == 1);
}


main :: proc() {
    // init glfw and create window
    window, status_glfw := init_glfw("Test\x00");
    if !status_glfw {
        return;
    }

    // load opengl function pointers
    
    gl.init( proc(p: rawptr, name: string) { (^(proc() #cc_c))(p)^ = glfw.GetProcAddress(&name[0]); } );

    // Optionally load shaders manually
    //success := mv_ef.init("extra/font_vertex_shader.vs", "extra/font_fragment_shader.fs");
    
    num := 15121; // draw 15121 characters simultaneously

    // random colors, there are currently up to 9 colors to choose from
    col := make([]u8, num);
    defer free(col);
    for i in 0..< num {
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
        update_input(window);

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


// Minimal Standard LCG
seed : u32 = 12345;
rng :: proc() -> f64 {
    seed *= 16807;
    return f64(seed) / f64(0x100000000);
}
