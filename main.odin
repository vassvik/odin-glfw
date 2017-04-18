#import glfw "glfw.odin";
#import gl "gl.odin";

#import "os.odin";
#import "fmt.odin";
#import "math.odin";

set_proc_address :: proc(p: rawptr, name: string) #inline { (cast(^(proc() #cc_c))p)^ = glfw.GetProcAddress(^name[0]); }

init_glfw :: proc(title: string) -> (^glfw.window, bool) {
    if glfw.Init() == 0 {
        fmt.println("Error initializing GLFW");
        return nil, false;
    }

    glfw.WindowHint(glfw.SAMPLES, 4);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3);
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE);
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, 1);
    window := glfw.CreateWindow(640, 480, cast(^byte)^title[0], nil, nil);
    if window == nil {
        fmt.println("Error creating window");
        glfw.Terminate();
        return nil, false;
    }

    glfw.MakeContextCurrent(window);
    glfw.SwapInterval(1);

    return window, true;
}


init_buffers_and_texture :: proc(program: u32) -> (u32, u32, u32, u32) {
    using gl;

    // create and bind vao
    vao : u32;
    GenVertexArrays(1, ^vao);
    BindVertexArray(vao);

    // create position object and data, and upload it
    num_vertices := 12;
    pos_data := [..]f32 {
       -1.0, -1.0, // left quad, first triangle (lower left)
       -0.1, -1.0,
       -1.0,  1.0,

       -1.0,  1.0, // left quad, second triangle (upper right)
       -0.1, -1.0,
       -0.1,  1.0,

        0.1, -1.0, // second quad, first triangle (lower left)
        1.0, -1.0,
        0.1,  1.0,

        0.1,  1.0, // second quad, second triangle (upper right)
        1.0, -1.0,
        1.0,  1.0,
    };

    vbo_pos: u32;
    GenBuffers(1, ^vbo_pos);
    BindBuffer(ARRAY_BUFFER, vbo_pos);
    BufferData(ARRAY_BUFFER, len(pos_data) * size_of_val(pos_data[0]), ^pos_data[0], STATIC_DRAW);
    
    EnableVertexAttribArray(0);
    VertexAttribPointer(0, 2, FLOAT, FALSE, 0, nil);

    // create uv object and data, and upload it
    uv_data := [..]f32 {
        0.0, 0.0, // left quad, first triangle (lower left)
        0.5, 0.0,  
        0.0, 1.0, 
        
        0.0, 1.0, // left quad, second triangle (upper right)
        0.5, 0.0, 
        0.5, 1.0, 
        
        0.5, 0.0, // second quad, first triangle (lower left)
        1.0, 0.0, 
        0.5, 1.0, 
        
        0.5, 1.0, // second quad, second triangle (upper right)
        1.0, 0.0, 
        1.0, 1.0, 
    };

    vbo_uv: u32;
    GenBuffers(1, ^vbo_uv);
    BindBuffer(ARRAY_BUFFER, vbo_uv);
    BufferData(ARRAY_BUFFER, len(uv_data) * size_of_val(uv_data[0]), ^uv_data[0], STATIC_DRAW);

    EnableVertexAttribArray(1);
    VertexAttribPointer(1, 2, FLOAT, FALSE, 0, nil);

    // create 2D texture and upload it
    texture_data := [..]u8 {
        255, 152,   0, // orange
        156,  39, 176, // purple
          3, 169, 244, // light blue
        139, 195,  74, // light green

        255,  87,  34, // deep orange
        103,  58, 183, // deep purple
          0, 188, 212, // cyan
        205, 220,  57, // lime

        244,  67,  54, // red
         63,  81, 181, // indigo
          0, 150, 137, // teal
        255, 235,  59, // yellow
        
        233,  30,  99, // pink
         33, 150, 243, // blue
         76, 175,  80, // green
        255, 193,   7, // amber
    };

    texture : u32;
    GenTextures(1, ^texture);
    ActiveTexture(TEXTURE0);
    BindTexture(TEXTURE_2D, texture);

    TexParameteri(TEXTURE_2D, TEXTURE_MIN_FILTER, NEAREST);
    TexParameteri(TEXTURE_2D, TEXTURE_MAG_FILTER, NEAREST);
    TexParameteri(TEXTURE_2D, TEXTURE_WRAP_S, REPEAT);
    TexParameteri(TEXTURE_2D, TEXTURE_WRAP_T, REPEAT);
    TexImage2D(TEXTURE_2D, 0, RGB, 4, 4, 0, RGB, UNSIGNED_BYTE, ^texture_data[0]);

    // set texture uniform
    UseProgram(program);

    name := "texture_sampler";
    Uniform1i(GetUniformLocation(program, ^name[0]), 0);

    return vao, vbo_pos, vbo_uv, texture;
}

Draw :: proc(program, vao, texture: u32, num_vertices: u32) {
    using gl;

    UseProgram(program);
    BindVertexArray(vao);

    ActiveTexture(TEXTURE0);
    BindTexture(TEXTURE_2D, texture);

    DrawArrays(TRIANGLES, 0, num_vertices);
}



main :: proc() {
    // init glfw and create window
    window, status_glfw := init_glfw("Test");
    if !status_glfw {
        return;
    }

    // load opengl function pointers
    gl.init();

    // load shaders and create program
    program, status_program := load_shaders("vertex_shader.vs", "fragment_shader.fs");

    if !status_program {
        fmt.println("Error: Could not create program");
        glfw.Terminate();
        return;
    }

    // create opengl data
    vao, vbo_pos, vbo_uv, texture := init_buffers_and_texture(program);
    
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
        Draw(program, vao, texture, 12);
        glfw.SwapBuffers(window);
    }

    glfw.Terminate();
}



load_shaders :: proc(vertex_shader_filename, fragment_shader_filename: string) -> (u32, bool) {
    using gl;
    // Shader checking and linking checking are identical 
    // except for calling differently named GL functions
    // it's a bit ugly looking, but meh
    check_error :: proc(id: u32, status: i32, 
                        iv_func: proc(u32, i32, ^i32) #cc_c, 
                        log_func: proc(u32, u32, ^u32, ^byte) #cc_c) -> (bool) {
        result, info_log_length : i32;
        iv_func(id, status, ^result);
        iv_func(id, INFO_LOG_LENGTH, ^info_log_length);

        if result == 0 {
            error_message := make([]byte, info_log_length);
            defer free(error_message);

            log_func(id, cast(u32)info_log_length, nil, ^error_message[0]);
            fmt.printf(cast(string)error_message[..len(error_message)-1]); 

            return true;
        }

        return false;
    }

    // Compiling shaders are identical for any shader (vertex, geometry, fragment, tesselation, compute)
    compile_shader_from_file :: proc(shader_filename: string, shader_type: i32) -> (u32, bool) {
        shader_code, ok := os.read_entire_file(shader_filename);
        if !ok {
            fmt.printf("Could not load file \"%s\"\n", shader_filename);
            return 0, false;
        }
        defer free(shader_code);

        shader_id := CreateShader(shader_type);
        ShaderSource(shader_id, 1, cast(^^byte)^shader_code, nil);
        CompileShader(shader_id);

        if (check_error(shader_id, COMPILE_STATUS, GetShaderiv, GetShaderInfoLog)) {
            return 0, false;
        }

        return shader_id, true;
    }

    // only used once, but I'd just make a subprocedure(?) for consistency
    create_and_link_program :: proc(shader_ids: []u32) -> (u32, bool) {
        program_id := CreateProgram();
        for id in shader_ids {
            AttachShader(program_id, id);   
        }
        LinkProgram(program_id);

        if (check_error(program_id, LINK_STATUS, GetProgramiv, GetProgramInfoLog)) {
            return 0, false;
        }

        return program_id, true;
    }

    vertex_shader_id, ok1 := compile_shader_from_file(vertex_shader_filename, VERTEX_SHADER);
    defer DeleteShader(vertex_shader_id);

    fragment_shader_id, ok2 := compile_shader_from_file(fragment_shader_filename, FRAGMENT_SHADER);
    defer DeleteShader(fragment_shader_id);

    if (!ok1 || !ok2) {
        return 0, false;
    }

    program_id, ok := create_and_link_program([]u32{vertex_shader_id, fragment_shader_id});
    if (!ok) {
        return 0, false;
    }

    return program_id, true;
}

// globals for timings
t1 := 0.0;
avg_dt := 0.0;
avg_dt2 := 0.0;
num_samples := 60;
counter := 0;
calculate_frame_timings :: proc(window: ^glfw.window) {
    t2 := glfw.GetTime();
    dt := t2-t1;
    t1 = t2;

    avg_dt += dt;
    avg_dt2 += dt*dt;
    counter++;

    if counter == num_samples {
        avg_dt  /= cast(f64)num_samples;
        avg_dt2 /= cast(f64)num_samples;
        std_dt := math.sqrt(avg_dt2 - avg_dt*avg_dt);
        ste_dt := std_dt/math.sqrt(cast(f64)num_samples);

        // avg: frame time average over num_samples frames
        // std: standard deviation calculated over those frames
        // ste: standard error (standard deviation of the average) calculated over those frames
        title: [128]byte;
        fmt.sprintf(title[..0], "dt: avg = %.3fms, std = %.3fms, ste = %.4fms. fps = %.1f", 1000.0*avg_dt, 1000.0*std_dt, 1000.0*ste_dt, 1.0/avg_dt);
        glfw.SetWindowTitle(window, cast(^byte)^title[0]);
        
        num_samples = cast(int)(1.0/avg_dt);
        
        avg_dt = 0.0;
        avg_dt2 = 0.0;
        counter = 0;
    }
}