import {
    "fmt.odin";
    "strings.odin";
    "glfw.odin";
}

proc error_callback(error: i32, desc: ^u8) #cc_c {
    fmt.printf("Error code %d:\n    %s\n", error, strings.to_odin_string(desc));
}

proc init_glfw() -> (^glfw.window, bool) {
    glfw.SetErrorCallback(error_callback);

    if glfw.Init() == 0 {
        return nil, false;
    }

    glfw.WindowHint(glfw.SAMPLES, 4);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3);
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3);
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE);
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, 1);

    var title = "blah\x00";
    //defer free(title);
    var window = glfw.CreateWindow(1280, 720, &title[0], nil, nil);
    if window == nil {
        return nil, false;
    }

    glfw.MakeContextCurrent(window);

    return window, true;
}

// OpenGL constants, only the ones we need
// more can be found in opengl_constants.odin in core/
const {
    FALSE            = 0x0000;
    TRIANGLES        = 0x0004;
    FLOAT            = 0x1406;
    COLOR_BUFFER_BIT = 0x4000;
    ARRAY_BUFFER     = 0x8892;
    STATIC_DRAW      = 0x88E4;
    VERTEX_SHADER    = 0x8B31;
    FRAGMENT_SHADER  = 0x8B30;
}

// OpenGL functions, only the ones we need
// For more, look up http://docs.gl, where you can sort by version
var {

    ClearColor: proc(r, g, b, a: f32) #cc_c;
    Clear: proc(mask: u32) #cc_c;

    GenVertexArrays: proc(count: i32, buffers: ^u32) #cc_c;
    BindVertexArray: proc(buffer: u32) #cc_c;
    DeleteVertexArrays: proc(n: i32, arrays: ^u32) #cc_c;

    GenBuffers: proc(count: i32, buffers: ^u32) #cc_c;
    BindBuffer: proc(target: i32, buffer: u32) #cc_c;
    BufferData: proc(target: i32, size: int, data: rawptr, usage: i32) #cc_c;
    DeleteBuffers: proc(n: i32, buffers: ^u32) #cc_c;

    EnableVertexAttribArray: proc(index: u32) #cc_c;
    VertexAttribPointer: proc(index: u32, size, type_: i32, normalized: i32, stride: u32, pointer: rawptr) #cc_c;

    CreateShader: proc(shader_type: i32) -> u32 #cc_c;
    ShaderSource: proc(shader: u32, count: u32, str: ^^u8, length: ^i32) #cc_c;
    CompileShader: proc(shader: u32) #cc_c;
    DeleteShader: proc(shader:  u32) #cc_c;

    CreateProgram: proc() -> u32 #cc_c;
    AttachShader: proc(program, shader: u32) #cc_c;
    LinkProgram: proc(program: u32) #cc_c;
    DeleteProgram: proc(program: u32) #cc_c;

    UseProgram: proc(program: u32) #cc_c;
    GetUniformLocation: proc(program: u32, name: ^u8) -> i32 #cc_c;
    Uniform1f: proc(loc: i32, v0: f32) #cc_c;

    DrawArrays: proc(mode, first: i32, count: u32) #cc_c;
}


// GetProcAddress wrapper
proc set_proc_address(p: rawptr, name: string) {
    (^(proc() #cc_c))(p)^ = glfw.GetProcAddress(&name[0]);
}

// Get all the relevant OpenGL function pointers
proc get_gl_functions() {
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

    set_proc_address(&DrawArrays,              "glDrawArrays\x00");
}

// compiling and linking some hardcoded trivial shaders
proc load_shaders() -> u32 {
    var vertex_shader_source = 
    `#version 330 core

    layout(location = 0) in vec2 vertexPosition;

    void main() {
        gl_Position = vec4(vertexPosition, 0.0, 1.0);
    }
    `;

    var fragment_shader_source = 
    `#version 330 core

    uniform float time;

    out vec4 color;
    #define AA 2

    void main() {
        // Mandelbrot renderer, 
        // copy-paste of https://www.shadertoy.com/view/4df3Rn

        vec3 col = vec3(0.0);
        
        for( int m=0; m<AA; m++ )
        for( int n=0; n<AA; n++ )
        {
            vec2 p = (-vec2(1280.0, 720.0) + 2.0*(gl_FragCoord.xy+vec2(float(m),float(n))/float(AA)))/720.0;
            float w = float(AA*m+n);
            float t = time + 0.5*(1.0/24.0)*w/float(AA*AA);
        
            float zoo = 0.62 + 0.38*cos(.07*t);
            float coa = cos( 0.15*(1.0-zoo)*t );
            float sia = sin( 0.15*(1.0-zoo)*t );
            zoo = pow( zoo,8.0);
            vec2 xy = vec2( p.x*coa-p.y*sia, p.x*sia+p.y*coa);
            vec2 c = vec2(-.745,.186) + xy*zoo;

            const float B = 256.0;
            float l = 0.0;
            vec2 z  = vec2(0.0);
            for( int i=0; i<200; i++ )
            {
                // z = z*z + c      
                z = vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y ) + c;
            
                if( dot(z,z)>(B*B) ) break;

                l += 1.0;
            }

            // ------------------------------------------------------
            // smooth interation count
            //float sl = l - log(log(length(z))/log(256.0))/log(2.0);
            
            // equivalent optimized smooth interation count
            float sl = l - log2(log2(dot(z,z))) + 4.0; 
            // ------------------------------------------------------
        
            float al = smoothstep( -0.1, 0.0, sin(0.5*6.2831*time ) );
            l = mix( l, sl, al );

            col += 0.5 + 0.5*cos( 3.0 + l*0.15 + vec3(0.0,0.6,1.0));
        }
        col /= float(AA*AA);
        

        color = vec4( col, 1.0 );
    }
    `;

    var vertex_shader_length = i32(len(vertex_shader_source));
    var fragment_shader_length = i32(len(fragment_shader_source));

    var vertex_shader_id = CreateShader(VERTEX_SHADER);
    var fragment_shader_id = CreateShader(FRAGMENT_SHADER);

    defer {
        DeleteShader(vertex_shader_id);
        DeleteShader(fragment_shader_id);
    }

    ShaderSource(vertex_shader_id, 1, ^^u8(&vertex_shader_source), &vertex_shader_length);
    ShaderSource(fragment_shader_id, 1, ^^u8(&fragment_shader_source), &fragment_shader_length);

    CompileShader(vertex_shader_id);
    CompileShader(fragment_shader_id);

    var program = CreateProgram();
    AttachShader(program, vertex_shader_id);
    AttachShader(program, fragment_shader_id);
    LinkProgram(program);

    return program;
}

proc create_buffers() -> (u32, u32) {
    var vao: u32;
    GenVertexArrays(1, &vao);
    BindVertexArray(vao);

    // a quad, two triangles covering the whole screen in NDC
    var v = [..]f32{
        -1.0, -1.0, 
         1.0, -1.0, 
        -1.0,  1.0,
        -1.0,  1.0,
         1.0, -1.0,
         1.0,  1.0,
    };

    var vbo: u32;
    GenBuffers(1, &vbo);
    BindBuffer(ARRAY_BUFFER, vbo);
    BufferData(ARRAY_BUFFER, size_of(v), &v[0], STATIC_DRAW);

    EnableVertexAttribArray(0);
    VertexAttribPointer(0, 2, FLOAT, FALSE, 0, nil);

    return vao, vbo;
}

proc main() {
    var window, success = init_glfw();
    if !success {
        glfw.Terminate();
        return;
    }
    defer glfw.Terminate();

    get_gl_functions();

    var program = load_shaders();
    defer DeleteProgram(program);

    var vao, vbo = create_buffers();
    defer {
        DeleteBuffers(1, &vbo);
        DeleteVertexArrays(1, &vao);
    }

    // wrapper to use GetUniformLocation with an Odin string
    // @NOTE: str has to be zero-terminated, so add a \x00 at the end
    proc GetUniformLocation_(program: u32, str: string) -> i32 {
        return GetUniformLocation(program, &str[0]);;
    }

    ClearColor(0.5, 0.5, 0.8, 1.0);
    for glfw.WindowShouldClose(window) == glfw.FALSE {
        glfw.PollEvents();

        Clear(COLOR_BUFFER_BIT);

        UseProgram(program);
        Uniform1f(GetUniformLocation_(program, "time\x00"), f32(glfw.GetTime())); 
        
        BindVertexArray(vao);
        DrawArrays(TRIANGLES, 0, 6);

        glfw.SwapBuffers(window);
    }
}