#import "fmt.odin";
#import "math.odin";
#import "strings.odin";
#import "glfw.odin";

error_callback :: proc(error: i32, desc: ^byte) #cc_c {
    fmt.printf("Error code %d:\n    %s\n", error, strings.to_odin_string(desc));
}

init_glfw :: proc() -> (^glfw.window, bool) {
    glfw.SetErrorCallback(error_callback);

    if glfw.Init() == 0 {
        fmt.println("Error: Could not initialize GLFW.");
        return nil, false;
    }

    glfw.WindowHint(glfw.SAMPLES, 4);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3);
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE);
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, 1);


    title := "blah\x00";
    window := glfw.CreateWindow(1280, 720, ^byte(&title[0]), nil, nil);
    if window == nil {
        fmt.println("Error: Could not create window.");
        return nil, false;
    }

    glfw.MakeContextCurrent(window);
    glfw.SwapInterval(0);

    return window, true;
}

// OpenGL constants, only the ones we need
FALSE :: 0;
TRIANGLES :: 0x0004;
FLOAT :: 0x1406;
COLOR_BUFFER_BIT :: 0x00004000;
ARRAY_BUFFER  :: 0x8892;
STATIC_DRAW :: 0x88E4;
VERTEX_SHADER :: 0x8B31;
FRAGMENT_SHADER :: 0x8B30;

// OpenGL functions, only the ones we need
Clear:                    proc(mask: u32) #cc_c;
ClearColor:               proc(r, g, b, a: f32) #cc_c;

GenVertexArrays:          proc(count: i32, buffers: ^u32) #cc_c;
GenBuffers:               proc(count: i32, buffers: ^u32) #cc_c;
BindVertexArray:          proc(buffer: u32) #cc_c;
BindBuffer:               proc(target: i32, buffer: u32) #cc_c;
BufferData:               proc(target: i32, size: int, data: rawptr, usage: i32) #cc_c;

VertexAttribPointer:      proc(index: u32, size, type_: i32, normalized: i32, stride: u32, pointer: rawptr) #cc_c;
EnableVertexAttribArray:  proc(index: u32) #cc_c;

CreateShader:             proc(shader_type: i32) -> u32 #cc_c;
ShaderSource:             proc(shader: u32, count: u32, str: ^^byte, length: ^i32) #cc_c;
CompileShader:            proc(shader: u32) #cc_c;
DeleteShader:             proc(shader:  u32) #cc_c;

CreateProgram:            proc() -> u32 #cc_c;
AttachShader:             proc(program, shader: u32) #cc_c;
LinkProgram:              proc(program: u32) #cc_c;

UseProgram:               proc(program: u32) #cc_c;
Uniform1f:                proc(loc: i32, v0: f32) #cc_c;
GetUniformLocation:       proc(program: u32, name: ^byte) -> i32 #cc_c;

DrawArrays:               proc(mode, first: i32, count: u32) #cc_c;

UniformMatrix4fv:         proc(loc: i32, count: u32, transpose: i32, value: ^f32) #cc_c;


// GetProcAddress wrapper
set_proc_address :: proc(p: rawptr, name: string) {
    (^(proc() #cc_c))(p)^ = glfw.GetProcAddress(&name[0]);
}

// Get all the relevant OpenGL function pointers
get_gl_functions :: proc() {
    set_proc_address(&ClearColor,              "glClearColor\x00");
    set_proc_address(&Clear,                   "glClear\x00");
    set_proc_address(&GenBuffers,              "glGenBuffers\x00");
    set_proc_address(&GenVertexArrays,         "glGenVertexArrays\x00");
    set_proc_address(&BindBuffer,              "glBindBuffer\x00");
    set_proc_address(&BindVertexArray,         "glBindVertexArray\x00");
    set_proc_address(&BufferData,              "glBufferData\x00");
    set_proc_address(&DrawArrays,              "glDrawArrays\x00");
    set_proc_address(&VertexAttribPointer,     "glVertexAttribPointer\x00");
    set_proc_address(&EnableVertexAttribArray, "glEnableVertexAttribArray\x00");
    set_proc_address(&CreateShader,            "glCreateShader\x00");
    set_proc_address(&ShaderSource,            "glShaderSource\x00");
    set_proc_address(&CompileShader,           "glCompileShader\x00");
    set_proc_address(&CreateProgram,           "glCreateProgram\x00");
    set_proc_address(&AttachShader,            "glAttachShader\x00");
    set_proc_address(&LinkProgram,             "glLinkProgram\x00");
    set_proc_address(&UseProgram,              "glUseProgram\x00");
    set_proc_address(&Uniform1f,               "glUniform1f\x00");
    set_proc_address(&GetUniformLocation,      "glGetUniformLocation\x00");
    set_proc_address(&DeleteShader,            "glDeleteShader\x00");
    set_proc_address(&UniformMatrix4fv,        "glUniformMatrix4fv\x00");
}

// compiling and linking some hardcoded trivial shaders
load_shaders :: proc() -> u32 {
    vertex_shader_source := 
    `#version 330 core

    layout(location = 0) in vec2 vertexPosition;

    uniform float time;

    uniform mat4 MVP;

    out vec2 pos;

    vec2 rotate(vec2 v, float angle) {
        return vec2(v.x*cos(angle) - v.y*sin(angle), v.x*sin(angle) + v.y*cos(angle));
    }

    void main() {
        gl_Position = MVP*vec4(rotate(vertexPosition, 2*time), 0.0, 1.0);
        pos = vertexPosition;
    }
    `;

    fragment_shader_source := 
    `#version 330 core

    in vec2 pos;
    uniform float time;
    out vec4 color;

    void main() {
        color = vec4(pos.xy, 0.5 + 0.5*cos(time), 1.0);
    }`;

    vertex_shader_length := i32(len(vertex_shader_source));
    fragment_shader_length := i32(len(fragment_shader_source));

    vertex_shader_id := CreateShader(VERTEX_SHADER);
    ShaderSource(vertex_shader_id, 1, ^^byte(&vertex_shader_source), &vertex_shader_length);
    CompileShader(vertex_shader_id);

    fragment_shader_id := CreateShader(FRAGMENT_SHADER);
    ShaderSource(fragment_shader_id, 1, ^^byte(&fragment_shader_source), &fragment_shader_length);
    CompileShader(fragment_shader_id);

    program := CreateProgram();
    AttachShader(program, vertex_shader_id);
    AttachShader(program, fragment_shader_id);
    LinkProgram(program);

    DeleteShader(vertex_shader_id);
    DeleteShader(fragment_shader_id);

    return program;
}

create_buffers :: proc() -> u32 {
    vao : u32;
    GenVertexArrays(1, &vao);
    BindVertexArray(vao);

    v := [..]f32{
        0.0, 0.0, 
        1.0, 0.0, 
        0.0, 1.0,
    };

    vbo : u32;
    GenBuffers(1, &vbo);
    BindBuffer(ARRAY_BUFFER, vbo);
    BufferData(ARRAY_BUFFER, 4*6, &v[0], STATIC_DRAW);

    EnableVertexAttribArray(0);
    VertexAttribPointer(0, 2, FLOAT, FALSE, 0, nil);

    return vao;
}

main :: proc() {
    window, success := init_glfw();
    if !success {
        glfw.Terminate();
        return;
    }

    get_gl_functions();

    program := load_shaders();
    vao := create_buffers();

    // wrapper to use GetUniformLocation with an Odin string
    GetUniformLocation_ :: proc(program: u32, str: string) -> i32 {
        return GetUniformLocation(program, &str[0]);;
    }

    p := math.Vec3{0.0, 0.0, 1.0};
    f := math.Vec3{0.0, 0.0, -1.0};
    r := math.Vec3{1.0, 0.0, 0.0};
    u := math.Vec3{0.0, 1.0, 0.0};

    theta, phi := f32(math.π), f32(math.π/2.0);


    mx_prev, my_prev: f64;
    glfw.GetCursorPos(window, &mx_prev, &my_prev);

    clamp :: proc(x, a, b: f32) -> f32 {
        return x < a ? a : x > b ? b : x;
    }

    t1 := glfw.GetTime();

    frame := 0;

    ClearColor(0.5, 0.5, 0.8, 1.0);
    for glfw.WindowShouldClose(window) == glfw.FALSE {

        t2 := glfw.GetTime();
        dt := f32(t2 - t1);
        t1 = t2;

        // input
        glfw.PollEvents();

        mx, my: f64;
        glfw.GetCursorPos(window, &mx, &my);

        if glfw.GetMouseButton(window, glfw.MOUSE_BUTTON_1) == glfw.PRESS {
            radiansPerPixel := f32(0.1 * math.π / 180.0);
            phi = phi - f32(mx - mx_prev) * radiansPerPixel;
            theta = clamp(theta + f32(my - my_prev) * radiansPerPixel, 1.0*math.π/180.0, 179.0*math.π/180.0);
        }

        mx_prev = mx;
        my_prev = my;

        sinp := math.sin(phi);
        cosp := math.cos(phi);

        sint := math.sin(theta);
        cost := math.cos(theta);

        f = math.Vec3{cosp*sint, sinp*sint, cost};                   // forward vector, normalized, spherical coordinates
        r = math.Vec3{sinp, -cosp, 0.0};                             // right vector, relative to forward
        u = math.Vec3{-cosp*cost, -sinp*cost, sint};                 // "up" vector, u = r x f

        p += f*f32(glfw.GetKey(window, glfw.KEY_W) - glfw.GetKey(window, glfw.KEY_S))*dt*1;
        p += r*f32(glfw.GetKey(window, glfw.KEY_D) - glfw.GetKey(window, glfw.KEY_A))*dt*1;
        p += u*f32(glfw.GetKey(window, glfw.KEY_E) - glfw.GetKey(window, glfw.KEY_Q))*dt*1;
        

        // drawing
        Clear(COLOR_BUFFER_BIT);

        M := math.mat4_identity();
        V := math.view(r, u, f, p);
        P := math.perspective(3.1415926*45.0/180.0, 1280/720.0, 0.0, 10.0);
        MV := math.mul(V, M);
        MVP := math.mul(P, MV);
        
        UseProgram(program);
        UniformMatrix4fv(GetUniformLocation_(program, "MVP"), 1, FALSE, &MVP[0][0]);
        Uniform1f(GetUniformLocation_(program, "time"), f32(glfw.GetTime()));

        BindVertexArray(vao);
        DrawArrays(TRIANGLES, 0, 3);

        glfw.SwapBuffers(window);
    }

    glfw.Terminate();
}