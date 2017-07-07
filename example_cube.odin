import (
    "fmt.odin";
    "math.odin";
    "strings.odin";
    "glfw.odin";
)

// called every time GLFW encounters an error.
error_callback :: proc(error: i32, desc: ^u8) #cc_c {
    fmt.printf("Error code %d:\n    %s\n", error, strings.to_odin_string(desc));
}

init_glfw :: proc() -> (^glfw.window, bool) {
    glfw.SetErrorCallback(error_callback);

    if glfw.Init() == 0 {
        return nil, false;
    }

    glfw.WindowHint(glfw.SAMPLES, 4);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3);
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE);
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, 1);

    title := "Odin GLFW example: Rotating cube \x00";
    window := glfw.CreateWindow(1280, 720, &title[0], nil, nil);
    if window == nil {
        return nil, false;
    }

    glfw.MakeContextCurrent(window);
    glfw.SwapInterval(0); // V-sync off, if possible

    return window, true;
}

// OpenGL constants, only the ones we need
// more can be found in opengl_constants.odin in core/
FALSE                :: 0x0000;
TRIANGLE_STRIP       :: 0x0005;
DEPTH_BUFFER_BIT     :: 0x0100;
DEPTH_TEST           :: 0x0B71;
UNSIGNED_SHORT       :: 0x1403;
FLOAT                :: 0x1406;
COLOR_BUFFER_BIT     :: 0x4000;
ARRAY_BUFFER         :: 0x8892;
ELEMENT_ARRAY_BUFFER :: 0x8893;
STATIC_DRAW          :: 0x88E4;
VERTEX_SHADER        :: 0x8B31;
FRAGMENT_SHADER      :: 0x8B30;

// OpenGL functions, only the ones we need
// For more, look up http://docs.gl, where you can sort by version
Enable:                   proc(cap: u32) #cc_c;

ClearColor:               proc(r, g, b, a: f32) #cc_c;
Clear:                    proc(mask: u32) #cc_c;

GenVertexArrays:          proc(count: i32, buffers: ^u32) #cc_c;
BindVertexArray:          proc(buffer: u32) #cc_c;
DeleteVertexArrays:       proc(n: i32, arrays: ^u32) #cc_c;

GenBuffers:               proc(count: i32, buffers: ^u32) #cc_c;
BindBuffer:               proc(target: i32, buffer: u32) #cc_c;
BufferData:               proc(target: i32, size: int, data: rawptr, usage: i32) #cc_c;
DeleteBuffers:            proc(n: i32, buffers: ^u32) #cc_c;

EnableVertexAttribArray:  proc(index: u32) #cc_c;
VertexAttribPointer:      proc(index: u32, size, type_: i32, normalized: i32, stride: u32, pointer: rawptr) #cc_c;

CreateShader:             proc(shader_type: i32) -> u32 #cc_c;
ShaderSource:             proc(shader: u32, count: u32, str: ^^u8, length: ^i32) #cc_c;
CompileShader:            proc(shader: u32) #cc_c;
DeleteShader:             proc(shader:  u32) #cc_c;

CreateProgram:            proc() -> u32 #cc_c;
AttachShader:             proc(program, shader: u32) #cc_c;
LinkProgram:              proc(program: u32) #cc_c;
DeleteProgram:            proc(program: u32) #cc_c;

UseProgram:               proc(program: u32) #cc_c;
GetUniformLocation:       proc(program: u32, name: ^u8) -> i32 #cc_c;
Uniform1f:                proc(loc: i32, v0: f32) #cc_c;
UniformMatrix4fv:         proc(loc: i32, count: u32, transpose: i32, value: ^f32) #cc_c;

DrawElements:             proc(mode: i32, count: u32, type_: i32, indices: rawptr) #cc_c;

// GetProcAddress wrapper
set_proc_address :: proc(p: rawptr, name: string) {
    ^rawptr(p)^ = rawptr(glfw.GetProcAddress(&name[0]));
}

// Get all the relevant OpenGL function pointers
get_gl_functions :: proc() {
    set_proc_address(&Enable,                  "glEnable\x00");

    set_proc_address(&ClearColor,              "glClearColor\x00");
    set_proc_address(&Clear,                   "glClear\x00");

    set_proc_address(&GenBuffers,              "glGenBuffers\x00");
    set_proc_address(&GenVertexArrays,         "glGenVertexArrays\x00");
    set_proc_address(&DeleteVertexArrays,      "glDeleteVertexArrays\x00");

    set_proc_address(&BindBuffer,              "glBindBuffer\x00");
    set_proc_address(&BindVertexArray,         "glBindVertexArray\x00");
    set_proc_address(&BufferData,              "glBufferData\x00");
    set_proc_address(&DeleteBuffers,           "glDeleteBuffers\x00");

    set_proc_address(&EnableVertexAttribArray, "glEnableVertexAttribArray\x00");
    set_proc_address(&VertexAttribPointer,     "glVertexAttribPointer\x00");

    set_proc_address(&CreateShader,            "glCreateShader\x00");
    set_proc_address(&ShaderSource,            "glShaderSource\x00");
    set_proc_address(&CompileShader,           "glCompileShader\x00");
    set_proc_address(&DeleteShader,            "glDeleteShader\x00");
    
    set_proc_address(&CreateProgram,           "glCreateProgram\x00");
    set_proc_address(&AttachShader,            "glAttachShader\x00");
    set_proc_address(&LinkProgram,             "glLinkProgram\x00");
    set_proc_address(&DeleteProgram,           "glDeleteProgram\x00");
    
    set_proc_address(&UseProgram,              "glUseProgram\x00");
    set_proc_address(&GetUniformLocation,      "glGetUniformLocation\x00");
    set_proc_address(&Uniform1f,               "glUniform1f\x00");
    set_proc_address(&UniformMatrix4fv,        "glUniformMatrix4fv\x00");

    set_proc_address(&DrawElements,            "glDrawElements\x00");
}

// Compiling and linking some hardcoded trivial shaders
// @WARNING: No error checking.
load_shaders :: proc() -> u32 {
    vertex_shader_source := 
    `#version 330 core

    layout(location = 0) in vec3 vertexPosition;

    uniform float time;
    uniform mat4 MVP;

    out vec3 pos;

    void main() {
        gl_Position = MVP*vec4(vertexPosition, 1.0);
        pos = vertexPosition;
    }
    `;

    fragment_shader_source := 
    `#version 330 core

    in vec3 pos;
    uniform float time;
    out vec4 color;

    void main() {
        color = vec4(0.5 + 0.5*pos, 1.0);
    }
    `;

    vertex_shader_length := i32(len(vertex_shader_source));
    fragment_shader_length := i32(len(fragment_shader_source));

    vertex_shader_id := CreateShader(VERTEX_SHADER);
    fragment_shader_id := CreateShader(FRAGMENT_SHADER);

    defer {
        DeleteShader(vertex_shader_id);
        DeleteShader(fragment_shader_id);
    }

    ShaderSource(vertex_shader_id, 1, ^^u8(&vertex_shader_source), &vertex_shader_length);
    ShaderSource(fragment_shader_id, 1, ^^u8(&fragment_shader_source), &fragment_shader_length);

    CompileShader(vertex_shader_id);
    CompileShader(fragment_shader_id);

    program := CreateProgram();
    AttachShader(program, vertex_shader_id);
    AttachShader(program, fragment_shader_id);
    LinkProgram(program);

    return program;
}

create_buffers :: proc() -> (u32, u32, u32) {
    vao: u32;
    GenVertexArrays(1, &vao);
    BindVertexArray(vao);

    // a 2x2x2 cube, using triangle strips and indices
    cubeVertices := [...]f32 {
        -1.0, -1.0,  1.0,
         1.0, -1.0,  1.0,
        -1.0,  1.0,  1.0,
         1.0,  1.0,  1.0,
        -1.0, -1.0, -1.0,
         1.0, -1.0, -1.0,
        -1.0,  1.0, -1.0,
         1.0,  1.0, -1.0,
    };

    cubeIndices := [...]u16{
        // TRIANGLE_STRIP, 14 indices = 12 triangles
        0, 1, 2, 3, 7, 1, 5, 4, 7, 6, 2, 4, 0, 1
    };

    vbo: u32;
    GenBuffers(1, &vbo);
    BindBuffer(ARRAY_BUFFER, vbo);
    BufferData(ARRAY_BUFFER, size_of(cubeVertices), &cubeVertices[0], STATIC_DRAW);

    EnableVertexAttribArray(0);
    VertexAttribPointer(0, 3, FLOAT, FALSE, 0, nil);

    ebo: u32;
    GenBuffers(1, &ebo);
    BindBuffer(ELEMENT_ARRAY_BUFFER, ebo);
    BufferData(ELEMENT_ARRAY_BUFFER, size_of(cubeIndices), &cubeIndices[0], STATIC_DRAW);

    return vao, vbo, ebo;
}

// Right handed view matrix, defined from camera position and a local 
// camera coordinate system, namely right (X), up (Y) and forward (-Z).
// Hopefully this one gets added to core/math.odin eventually.
view :: proc(r, u, f, p: math.Vec3) -> math.Mat4 { 
    return math.Mat4 {
        {+r.x, +u.x, -f.x, 0.0},
        {+r.y, +u.y, -f.y, 0.0},
        {+r.z, +u.z, -f.z, 0.0},
        {-math.dot(r,p), -math.dot(u,p), math.dot(f,p), 1.0},
    };
}

// wrapper to use GetUniformLocation with an Odin string
// @NOTE: str has to be zero-terminated, so add a \x00 at the end
GetUniformLocation_ :: proc(program: u32, str: string) -> i32 {
    return GetUniformLocation(program, &str[0]);;
}

main :: proc() {
    window, success := init_glfw();
    if !success {
        glfw.Terminate();
        return;
    }
    defer glfw.Terminate();

    get_gl_functions();

    program := load_shaders();
    defer DeleteProgram(program);

    vao, vbo, ebo := create_buffers();
    defer {
        DeleteBuffers(1, &vbo);
        DeleteBuffers(1, &ebo);
        DeleteVertexArrays(1, &vao);
    }

    // Camera variables: position and camera direction defined by spherical coordinates
    // @NOTE: +Z is UP!
    p := math.Vec3{0.0, 0.0, 5.0};

    // @NOTE: The camera directions use spherical coordianates, 
    //        in particular, physics conventions are used: 
    //        theta is up-down, phi is left-right
    theta, phi := f32(math.π), f32(math.π/2.0);

    sinp, cosp := math.sin(phi),   math.cos(phi);
    sint, cost := math.sin(theta), math.cos(theta);

    f := math.Vec3{cosp*sint, sinp*sint, cost};                   // forward vector, normalized, spherical coordinates
    r := math.Vec3{sinp, -cosp, 0.0};                             // right vector, relative to forward
    u := math.Vec3{-cosp*cost, -sinp*cost, sint};                 // "up" vector, u = r x f

    // for mouse movement
    mx_prev, my_prev: f64;
    glfw.GetCursorPos(window, &mx_prev, &my_prev);

    // for timings
    t_prev := glfw.GetTime();
    frame := 0;

    Enable(DEPTH_TEST);
    ClearColor(0.2, 0.3, 0.4, 1.0);
    for glfw.WindowShouldClose(window) == glfw.FALSE {

        // time delta for fps-independent movement speed
        t_now := glfw.GetTime();
        dt := f32(t_now - t_prev);
        t_prev = t_now;

        // input
        glfw.PollEvents();

        // get current mouse position
        mx, my: f64;
        glfw.GetCursorPos(window, &mx, &my);

        // update camera direction
        if glfw.GetMouseButton(window, glfw.MOUSE_BUTTON_1) == glfw.PRESS {
            radiansPerPixel := f32(0.1 * math.π / 180.0);
            phi = phi - f32(mx - mx_prev) * radiansPerPixel;
            theta = clamp(theta + f32(my - my_prev) * radiansPerPixel, 1.0*math.π/180.0, 179.0*math.π/180.0);
        }

        mx_prev = mx;
        my_prev = my;

        // calculate updated local camera coordinate system
        sinp, cosp = math.sin(phi),   math.cos(phi);
        sint, cost = math.sin(theta), math.cos(theta);

        f = math.Vec3{cosp*sint, sinp*sint, cost};                   // forward vector, normalized, spherical coordinates
        r = math.Vec3{sinp, -cosp, 0.0};                             // right vector, relative to forward
        u = math.Vec3{-cosp*cost, -sinp*cost, sint};                 // "up" vector, u = r x f

        // update camera position:
        // W: forward, S: back, A: left, D: right, E: up, Q: down
        p += f*f32(glfw.GetKey(window, glfw.KEY_W) - glfw.GetKey(window, glfw.KEY_S))*dt;
        p += r*f32(glfw.GetKey(window, glfw.KEY_D) - glfw.GetKey(window, glfw.KEY_A))*dt;
        p += u*f32(glfw.GetKey(window, glfw.KEY_E) - glfw.GetKey(window, glfw.KEY_Q))*dt;

        // Main drawing part
        Clear(COLOR_BUFFER_BIT | DEPTH_BUFFER_BIT);

        M := math.mat4_rotate(math.Vec3{1.0, 1.0, 1.0}, f32(glfw.GetTime()));
        V := view(r, u, f, p);
        P := math.perspective(3.1415926*45.0/180.0, 1280/720.0, 0.001, 10.0);
        MV := math.mul(V, M);
        MVP := math.mul(P, MV);
        
        UseProgram(program);
        UniformMatrix4fv(GetUniformLocation_(program, "MVP\x00"), 1, FALSE, &MVP[0][0]);
        Uniform1f(GetUniformLocation_(program, "time\x00"), f32(glfw.GetTime()));

        BindVertexArray(vao);
        DrawElements(TRIANGLE_STRIP, 14, UNSIGNED_SHORT, nil);

        glfw.SwapBuffers(window);
    }
}