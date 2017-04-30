#load "opengl_constants.odin";

#import "glfw.odin"; // for glfw.GetProcAddress

GenBuffers:               proc(count: i32, buffers: ^u32) #cc_c;
GenVertexArrays:          proc(count: i32, buffers: ^u32) #cc_c;
GenSamplers:              proc(count: i32, buffers: ^u32) #cc_c;
BindBuffer:               proc(target: i32, buffer: u32) #cc_c;
BindVertexArray:          proc(buffer: u32) #cc_c;
BindSampler:              proc(position: i32, sampler: u32) #cc_c;
BufferData:               proc(target: i32, size: int, data: rawptr, usage: i32) #cc_c;
BufferSubData:            proc(target: i32, offset, size: int, data: rawptr) #cc_c;

DrawArrays:               proc(mode, first: i32, count: u32) #cc_c;
DrawElements:             proc(mode: i32, count: u32, type_: i32, indices: rawptr) #cc_c;

MapBuffer:                proc(target, access: i32) -> rawptr #cc_c;
UnmapBuffer:              proc(target: i32) #cc_c;

VertexAttribPointer:      proc(index: u32, size, type_: i32, normalized: i32, stride: u32, pointer: rawptr) #cc_c;
EnableVertexAttribArray:  proc(index: u32) #cc_c;

CreateShader:             proc(shader_type: i32) -> u32 #cc_c;
ShaderSource:             proc(shader: u32, count: u32, str: ^^byte, length: ^i32) #cc_c;
CompileShader:            proc(shader: u32) #cc_c;
CreateProgram:            proc() -> u32 #cc_c;
AttachShader:             proc(program, shader: u32) #cc_c;
DetachShader:             proc(program, shader: u32) #cc_c;
DeleteShader:             proc(shader:  u32) #cc_c;
LinkProgram:              proc(program: u32) #cc_c;
UseProgram:               proc(program: u32) #cc_c;
DeleteProgram:            proc(program: u32) #cc_c;


GetShaderiv:              proc(shader:  u32, pname: i32, params: ^i32) #cc_c;
GetProgramiv:             proc(program: u32, pname: i32, params: ^i32) #cc_c;
GetShaderInfoLog:         proc(shader:  u32, max_length: u32, length: ^u32, info_long: ^byte) #cc_c;
GetProgramInfoLog:        proc(program: u32, max_length: u32, length: ^u32, info_long: ^byte) #cc_c;

ActiveTexture:            proc(texture: i32) #cc_c;
GenerateMipmap:           proc(target:  i32) #cc_c;

SamplerParameteri:        proc(sampler: u32, pname: i32, param: i32) #cc_c;
SamplerParameterf:        proc(sampler: u32, pname: i32, param: f32) #cc_c;
SamplerParameteriv:       proc(sampler: u32, pname: i32, params: ^i32) #cc_c;
SamplerParameterfv:       proc(sampler: u32, pname: i32, params: ^f32) #cc_c;
SamplerParameterIiv:      proc(sampler: u32, pname: i32, params: ^i32) #cc_c;
SamplerParameterIuiv:     proc(sampler: u32, pname: i32, params: ^u32) #cc_c;


Uniform1i:                proc(loc: i32, v0: i32) #cc_c;
Uniform2i:                proc(loc: i32, v0, v1: i32) #cc_c;
Uniform3i:                proc(loc: i32, v0, v1, v2: i32) #cc_c;
Uniform4i:                proc(loc: i32, v0, v1, v2, v3: i32) #cc_c;
Uniform1f:                proc(loc: i32, v0: f32) #cc_c;
Uniform2f:                proc(loc: i32, v0, v1: f32) #cc_c;
Uniform3f:                proc(loc: i32, v0, v1, v2: f32) #cc_c;
Uniform4f:                proc(loc: i32, v0, v1, v2, v3: f32) #cc_c;
UniformMatrix4fv:         proc(loc: i32, count: u32, transpose: i32, value: ^f32) #cc_c;

GetUniformLocation:       proc(program: u32, name: ^byte) -> i32 #cc_c;

GenTextures:              proc(count: i32, result: ^u32) #cc_c;
BindTexture:              proc(target: i32, texture: u32) #cc_c;
TexParameteri:            proc(target, pname, param: i32) #cc_c;
TexImage1D:               proc(target, level, internal_format, width, border, format, type: i32, pixels: rawptr) #cc_c;
TexImage2D:               proc(target, level, internal_format, width, height, border, format, type: i32, pixels: rawptr) #cc_c;

ClearColor:               proc(r, g, b, a: f32) #cc_c;
Clear:                    proc(mask: u32) #cc_c;

VertexAttribDivisor:      proc(divisor, index: u32) #cc_c;
GetIntegerv:              proc(pname: u32, data: ^i32) #cc_c;
IsEnabled:                proc(cap: u32) -> u8 #cc_c;
BlendEquation:            proc(mode: u32) #cc_c;
BlendFunc:                proc(sfactor, dfactor: u32) #cc_c;
Disable:                  proc(cap: u32) #cc_c;
Enable:                   proc(cap: u32) #cc_c;
DrawArraysInstanced:      proc(mode: u32, first: i32, count, primcount: i32) #cc_c;
BlendEquationSeparate:    proc(modeRGB, modeAlpha: u32) #cc_c;


init :: proc() {
	set_proc_address :: proc(p: rawptr, name: string) #inline { (cast(^(proc() #cc_c))p)^ = glfw.GetProcAddress(^name[0]); }
	
	set_proc_address(^ClearColor,              "glClearColor\x00");
	set_proc_address(^Clear,                   "glClear\x00");

	set_proc_address(^GenTextures,             "glGenTextures\x00");
	set_proc_address(^BindTexture,             "glBindTexture\x00");
	set_proc_address(^TexParameteri,           "glTexParameteri\x00");
	set_proc_address(^TexImage1D,              "glTexImage1D\x00");
	set_proc_address(^TexImage2D,              "glTexImage2D\x00");

	set_proc_address(^GenBuffers,              "glGenBuffers\x00");
	set_proc_address(^GenVertexArrays,         "glGenVertexArrays\x00");
	set_proc_address(^GenSamplers,             "glGenSamplers\x00");
	set_proc_address(^BindBuffer,              "glBindBuffer\x00");
	set_proc_address(^BindSampler,             "glBindSampler\x00");
	set_proc_address(^BindVertexArray,         "glBindVertexArray\x00");
	set_proc_address(^BufferData,              "glBufferData\x00");
	set_proc_address(^BufferSubData,           "glBufferSubData\x00");

	set_proc_address(^DrawArrays,              "glDrawArrays\x00");
	set_proc_address(^DrawElements,            "glDrawElements\x00");

	set_proc_address(^MapBuffer,               "glMapBuffer\x00");
	set_proc_address(^UnmapBuffer,             "glUnmapBuffer\x00");

	set_proc_address(^VertexAttribPointer,     "glVertexAttribPointer\x00");
	set_proc_address(^EnableVertexAttribArray, "glEnableVertexAttribArray\x00");

	set_proc_address(^CreateShader,            "glCreateShader\x00");
	set_proc_address(^ShaderSource,            "glShaderSource\x00");
	set_proc_address(^CompileShader,           "glCompileShader\x00");
	set_proc_address(^CreateProgram,           "glCreateProgram\x00");
	set_proc_address(^AttachShader,            "glAttachShader\x00");
	set_proc_address(^DetachShader,            "glDetachShader\x00");
	set_proc_address(^DeleteShader,            "glDeleteShader\x00");
	set_proc_address(^LinkProgram,             "glLinkProgram\x00");
	set_proc_address(^UseProgram,              "glUseProgram\x00");
	set_proc_address(^DeleteProgram,           "glDeleteProgram\x00");

	set_proc_address(^GetShaderiv,             "glGetShaderiv\x00");
	set_proc_address(^GetProgramiv,            "glGetProgramiv\x00");
	set_proc_address(^GetShaderInfoLog,        "glGetShaderInfoLog\x00");
	set_proc_address(^GetProgramInfoLog,       "glGetProgramInfoLog\x00");

	set_proc_address(^ActiveTexture,           "glActiveTexture\x00");
	set_proc_address(^GenerateMipmap,          "glGenerateMipmap\x00");

	set_proc_address(^Uniform1i,               "glUniform1i\x00");
	set_proc_address(^Uniform1f,               "glUniform1f\x00");
	set_proc_address(^Uniform2f,               "glUniform2f\x00");
	set_proc_address(^Uniform3f,               "glUniform3f\x00");
	set_proc_address(^UniformMatrix4fv,        "glUniformMatrix4fv\x00");

	set_proc_address(^GetUniformLocation,      "glGetUniformLocation\x00");

	set_proc_address(^SamplerParameteri,       "glSamplerParameteri\x00");
	set_proc_address(^SamplerParameterf,       "glSamplerParameterf\x00");
	set_proc_address(^SamplerParameteriv,      "glSamplerParameteriv\x00");
	set_proc_address(^SamplerParameterfv,      "glSamplerParameterfv\x00");
	set_proc_address(^SamplerParameterIiv,     "glSamplerParameterIiv\x00");
	set_proc_address(^SamplerParameterIuiv,    "glSamplerParameterIuiv\x00");

	set_proc_address(^VertexAttribDivisor,     "glVertexAttribDivisor\x00");
	set_proc_address(^GetIntegerv,             "glGetIntegerv\x00");
	set_proc_address(^IsEnabled,               "glIsEnabled\x00");
	set_proc_address(^BlendEquation,           "glBlendEquation\x00");
	set_proc_address(^BlendFunc,               "glBlendFunc\x00");
	set_proc_address(^Disable,                 "glDisable\x00");
	set_proc_address(^Enable,                  "glEnable\x00");
	set_proc_address(^DrawArraysInstanced,     "glDrawArraysInstanced\x00");
	set_proc_address(^BlendEquationSeparate,   "glBlendEquationSeparate\x00");
}

// Helper for loading shaders into a program

#import "os.odin";
#import "fmt.odin";

load_shaders :: proc(vertex_shader_filename, fragment_shader_filename: string) -> (u32, bool) {
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
            fmt.printf(cast(string)error_message[0..<len(error_message)-1]); 

            return true;
        }

        return false;
    }

    // Compiling shaders are identical for any shader (vertex, geometry, fragment, tesselation, (maybe compute too))
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

    // actual function from here
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
