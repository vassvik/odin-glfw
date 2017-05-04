#import "os.odin";
#import "gl.odin";
#import "fmt.odin";

GetUniformLocation_ :: proc(program: u32, str: string) -> i32 {
    return gl.GetUniformLocation(program, &str[0]);;
}

// from stb_truetype.h, which was used to create and pack the bitmap
stbtt_packedchar :: struct {
    x0, y0, x1, y1: u16,
    xoff, yoff:     f32,
    xadvance:       f32,
    xoff2, yoff2:   f32,
};

font_info :: struct {
	// stuff from file font.bin
    height:           i32,
    width:            i32,
    num_glyphs:       i32,
    font_size:        f32,
    ascent:           f32,
    descent:          f32,
    linegap:          f32,
    linedist:         f32,

    cdata:            []stbtt_packedchar, // length = num_glyphs
    bitmap:           []byte,             // size   = width*height


    // stuff used for drawing
    initialized:      bool,

    vao:              u32,
    program:          u32,

    texture_fontdata: u32, 
    texture_metadata: u32,
    texture_colors:   u32,
    
    vbo_quad:         u32,
    vbo_instances:    u32,
};

MAX_STRING_LEN :: 40000;
font : font_info;

// reading my arbitrary, pre-packed binary font file, as a substitute for stb_truetype.h
// the first 32 bytes are font global information, 
// then the next num_glyphs*sizeof(stbtt_packedchar) bytes are per-glyph info
// the finally the last widht*height bytes is the bitmap, uncompressed. 
get_font :: proc(filename: string) -> bool {
    font_data, success := os.read_entire_file(filename);
    defer free(font_data);

    if !success {
        return false;
    }

    data := slice_ptr(^byte(&font), 32);
    copy(data, font_data);

    font.cdata = make([]stbtt_packedchar, font.num_glyphs);
    bytes_of_cdata := size_of_val(font.cdata[0]) * font.num_glyphs;
    copy(slice_to_bytes(font.cdata), font_data[32..<(bytes_of_cdata+32)]);
    
    font.bitmap = make([]byte, font.width*font.height);
    start_of_bitmap := i32(len(font_data)) - font.width*font.height;
    copy(font.bitmap, font_data[start_of_bitmap..]);

    return true;
}

init :: proc(vs_filename, fs_filename: string) -> bool{

    if !get_font("font.bin") {
        fmt.println("Error, could not read font file");
        return false;
    }
    //defer free(info.cdata);  // @NOTE: Memoery leek? Freed on program exit anyway?
    //defer free(info.bitmap);

    success: bool;
    font.program, success = load_shaders(vs_filename, fs_filename);
    if !success {
    	fmt.println("Error, Could not create font program!");
    	return false;
    }

    gl.GenVertexArrays(1, &font.vao);
    gl.BindVertexArray(font.vao);

    // Create and define quad used for each glyph, just a rectangle of side length 1
    v := [..]f32{
        0.0, 0.0, 
        1.0, 0.0, 
        0.0, 1.0,
        0.0, 1.0,
        1.0, 0.0,
        1.0, 1.0
    };

    gl.GenBuffers(1, &font.vbo_quad);
    gl.BindBuffer(gl.ARRAY_BUFFER, font.vbo_quad);
    gl.BufferData(gl.ARRAY_BUFFER, 4*12, &v[0], gl.STATIC_DRAW);
    
    gl.EnableVertexAttribArray(0);
    gl.VertexAttribPointer(0, 2, gl.FLOAT, gl.FALSE, 0, nil);
    gl.VertexAttribDivisor(0, 0); // not instanced
    

    // Create and define vertex attribute used for instancing,
    // i.e. x and y position of each glyph, its character code (for texture lookup) 
    // and color index.
    // Updated when drawing
    gl.GenBuffers(1, &font.vbo_instances);
    gl.BindBuffer(gl.ARRAY_BUFFER, font.vbo_instances);
    gl.BufferData(gl.ARRAY_BUFFER, 4*4*MAX_STRING_LEN, nil, gl.DYNAMIC_DRAW);

    gl.EnableVertexAttribArray(1);
    gl.VertexAttribPointer(1, 4, gl.FLOAT, gl.FALSE, 0, nil);
    gl.VertexAttribDivisor(1, 1); // instanced


    // create and define font bitmap texture
    gl.GenTextures(1, &font.texture_fontdata);
    gl.ActiveTexture(gl.TEXTURE0);
    gl.BindTexture(gl.TEXTURE_2D, font.texture_fontdata);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RED, font.width, font.height, 0, gl.RED, gl.UNSIGNED_BYTE, &font.bitmap[0]);


    // Create and define font metadata texture.
    // Contains per-glyph relative offsets and size info
    // and information about where each glyph is located in the bitmap texture.
    // All values are normalized.
    gl.GenTextures(1, &font.texture_metadata);
    gl.ActiveTexture(gl.TEXTURE1);
    gl.BindTexture(gl.TEXTURE_2D, font.texture_metadata);

    texture_metadata := make([]f32, 8*font.num_glyphs);
    defer free(texture_metadata);
    
    for i in 0..<font.num_glyphs {
        k1 := 0*font.num_glyphs + i;
        texture_metadata[4*k1+0] = f32(font.cdata[i].x0)/f32(font.width);                     // lower left corner x coordiante.
        texture_metadata[4*k1+1] = f32(font.cdata[i].y0)/f32(font.height);                    // lower left corner y coordinate.
        texture_metadata[4*k1+2] = f32((font.cdata[i].x1-font.cdata[i].x0))/f32(font.width);  // width of glyph in bitmap texture.
        texture_metadata[4*k1+3] = f32((font.cdata[i].y1-font.cdata[i].y0))/f32(font.height); // height of glyphin bitmap texture..

        k2 := 1*font.num_glyphs + i;
        texture_metadata[4*k2+0] = f32(font.cdata[i].xoff)/f32(font.width);   // x-offset from baseline of lower left corner.
        texture_metadata[4*k2+1] = f32(font.cdata[i].yoff)/f32(font.height);  // y-offset from baseline of lower left corner.
        texture_metadata[4*k2+2] = f32(font.cdata[i].xoff2)/f32(font.width);  // x-offset from baseline of upper right corner.
        texture_metadata[4*k2+3] = f32(font.cdata[i].yoff2)/f32(font.height); // y-offset from baseline of upper right corner.
    }

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGBA32F, font.num_glyphs, 2, 0, gl.RGBA, gl.FLOAT, &texture_metadata[0]);

    // Create and define color palette texture.
    // Based on Sublime Text 3's syntax highlighting
    mv_ef_num_colors := 9;
    mv_ef_colors := [..]u8 {
        248, 248, 242, // foreground color
        249,  38, 114, // operator
        174, 129, 255, // numeric
        102, 217, 239, // function
        249,  38, 114, // keyword
        117, 113,  94, // comment
        102, 217, 239, // type
         73,  72,  62, // background color
         39,  40,  34  // clear color
    };

    gl.GenTextures(1, &font.texture_colors);
    gl.ActiveTexture(gl.TEXTURE2);
    gl.BindTexture(gl.TEXTURE_1D, font.texture_colors);
    gl.TexParameteri(gl.TEXTURE_1D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
    gl.TexParameteri(gl.TEXTURE_1D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
    gl.TexParameteri(gl.TEXTURE_1D, gl.TEXTURE_WRAP_S, gl.REPEAT);
    gl.TexImage1D(gl.TEXTURE_1D, 0, gl.RGB, i32(mv_ef_num_colors), 0, gl.RGB, gl.UNSIGNED_BYTE, &mv_ef_colors[0]);

    // Set constant uniforms
    gl.UseProgram(font.program);
    gl.Uniform1i(GetUniformLocation_(font.program, "sampler_font\x00"), 0);
    gl.Uniform1i(GetUniformLocation_(font.program, "sampler_meta\x00"), 1);
    gl.Uniform1i(GetUniformLocation_(font.program, "sampler_colors\x00"), 2);

    gl.Uniform2f(GetUniformLocation_(font.program, "res_bitmap\x00"), f32(font.width), f32(font.height));
    gl.Uniform2f(GetUniformLocation_(font.program, "res_meta\x00"),  f32(font.num_glyphs), 2.0);
    gl.Uniform1f(GetUniformLocation_(font.program, "num_colors\x00"),  f32(mv_ef_num_colors));
    gl.Uniform1f(GetUniformLocation_(font.program, "offset_firstline\x00"), font.linedist-font.linegap);

    font.initialized =  true;

    return true;
}


text_glyph_data : [4*MAX_STRING_LEN]f32;


// (offsetx, offsety) is the coordinate of the upper-left corner of the first character
// font_size is the size (in pixel) of the font. The vertex_shader scales relative to the actual font size 
draw :: proc(str: []u8, col: []u8, offsetx, offsety, font_size: f32) {
    len := len(str);

    if (len > MAX_STRING_LEN) {
        fmt.printf("Error: string too long. Returning\n");
        return;
    }

    // if this is the first time calling this function, and the library has not been initialized manually, initialize.
    if !font.initialized {
    	init("", "");
    }

    // parse the string and create instance data
    X, Y: f32;
    ctr := 0;
    for c, i in str {
        if c == '\n' {
            X = 0.0;
            Y -= font.linedist*(font_size/font.font_size);
            continue;
        }

        code_base := c-32; // first glyph is ' ', i.e. ascii code 32
        text_glyph_data[4*ctr+0] = X;                                  // x position of glyph (baseline)
        text_glyph_data[4*ctr+1] = Y;                                  // y position of glyph
        text_glyph_data[4*ctr+2] = f32(code_base);                 // character code for texture lookup
        text_glyph_data[4*ctr+3] = col != nil ? f32(col[i]) : 0.0; // color palette index 

        X += font.cdata[code_base].xadvance*(font_size/font.font_size); 
        ctr++;
    }

    // temporarily store OpenGL state, to revert to after drawing
    // such that this library does not interfere with what others might use
    // NOTE: Why are these i32, and not u32? GetIntegerv takes i32s, but why?
    last_program, last_vertex_array: i32; 
    last_texture0, last_texture1, last_texture2: i32; 
    last_blend_src, last_blend_dst: i32; 
    last_blend_equation_rgb, last_blend_equation_alpha: i32; 

    gl.GetIntegerv(gl.CURRENT_PROGRAM, &last_program);
    gl.GetIntegerv(gl.VERTEX_ARRAY_BINDING, &last_vertex_array);

    gl.ActiveTexture(gl.TEXTURE0); 
    gl.GetIntegerv(gl.TEXTURE_BINDING_2D, &last_texture0);
    gl.ActiveTexture(gl.TEXTURE1); 
    gl.GetIntegerv(gl.TEXTURE_BINDING_2D, &last_texture1);
    gl.ActiveTexture(gl.TEXTURE2); 
    gl.GetIntegerv(gl.TEXTURE_BINDING_1D, &last_texture2);

    gl.GetIntegerv(gl.BLEND_SRC, &last_blend_src);
    gl.GetIntegerv(gl.BLEND_DST, &last_blend_dst);
    gl.GetIntegerv(gl.BLEND_EQUATION_RGB,   &last_blend_equation_rgb);
    gl.GetIntegerv(gl.BLEND_EQUATION_ALPHA, &last_blend_equation_alpha);

    last_enable_blend      := gl.IsEnabled(gl.BLEND);
    last_enable_depth_test := gl.IsEnabled(gl.DEPTH_TEST);

    dims: [4]i32;
    gl.GetIntegerv(gl.VIEWPORT, &dims[0]);

    // Setup render state: alpha-blending enabled
    gl.Disable(gl.DEPTH_TEST);
    gl.Enable(gl.BLEND);
    gl.BlendEquation(gl.FUNC_ADD);
    gl.BlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);

   	// Bind textures and VAO
    gl.ActiveTexture(gl.TEXTURE0);
    gl.BindTexture(gl.TEXTURE_2D, font.texture_fontdata);
    gl.ActiveTexture(gl.TEXTURE1);
    gl.BindTexture(gl.TEXTURE_2D, font.texture_metadata);
    gl.ActiveTexture(gl.TEXTURE2);
    gl.BindTexture(gl.TEXTURE_1D, font.texture_colors);

    gl.BindVertexArray(font.vao);

    // Update varying uniforms
    gl.UseProgram(font.program);
    gl.Uniform1f(GetUniformLocation_(font.program, "scale_factor\x00"), font_size/font.font_size);
    gl.Uniform2f(GetUniformLocation_(font.program, "string_offset\x00"), offsetx, offsety);
    gl.Uniform2f(GetUniformLocation_(font.program, "resolution\x00"), f32(dims[2]), f32(dims[3]));

    // Actual uploading of instanced data
    gl.BindBuffer(gl.ARRAY_BUFFER, font.vbo_instances);
    gl.BufferSubData(gl.ARRAY_BUFFER, 0, 4*4*ctr, &text_glyph_data[0]);

    // Actual drawing
    gl.DrawArraysInstanced(gl.TRIANGLES, 0, 6, i32(ctr));

    
    // Restore modified GL state, Needs to be cast to u32, because OpenGL is dumb.
    gl.UseProgram(u32(last_program));
    
    gl.ActiveTexture(gl.TEXTURE0); 
    gl.BindTexture(gl.TEXTURE_2D, u32(last_texture0));
    gl.ActiveTexture(gl.TEXTURE1); 
    gl.BindTexture(gl.TEXTURE_2D, u32(last_texture1));
    gl.ActiveTexture(gl.TEXTURE2); 
    gl.BindTexture(gl.TEXTURE_1D, u32(last_texture2));

    gl.BlendEquationSeparate(u32(last_blend_equation_rgb), u32(last_blend_equation_alpha));
    gl.BindVertexArray(u32(last_vertex_array));
    gl.BlendFunc(u32(last_blend_src),u32(last_blend_dst));
    
    if last_enable_depth_test != 0 {
        gl.Enable(gl.DEPTH_TEST);
    } else {
        gl.Disable(gl.DEPTH_TEST);
    }
    if last_enable_blend != 0 {
        gl.Enable(gl.BLEND);
    } else {
        gl.Disable(gl.BLEND);
    }
}

// calculates pixel size of string in units of font_size
string_dimensions :: proc(str: string, font_size: f32) -> (f32, f32) {
    X, Y, W: f32;

    for g in str {
        if g == '\n' {
            if X > W {
                W = X;
            }
            X = 0;
            Y++;
        } else {
            X += font.cdata[g-32].xadvance * (font_size/font.font_size);
        }
    }

    if X != 0 {
        Y++;
        if W == 0 {
            W = X;
        }
    }

    return W, Y*font.linedist*(font_size/font.font_size);
}

// helper for loading shaders, linking and creating program
load_shaders :: proc(vertex_shader_filename, fragment_shader_filename: string) -> (u32, bool) {
	using gl;
    // Shader checking and linking checking are identical 
    // except for calling differently named GL functions
    // it's a bit ugly looking, but meh
    check_error :: proc(id: u32, status: i32, 
                        iv_func: proc(u32, i32, ^i32) #cc_c, 
                        log_func: proc(u32, u32, ^u32, ^byte) #cc_c) -> (bool) {
        result, info_log_length : i32;
        iv_func(id, status, &result);
        iv_func(id, INFO_LOG_LENGTH, &info_log_length);

        if result == 0 {
            error_message := make([]byte, info_log_length);
            defer free(error_message);

            log_func(id,u32(info_log_length), nil, &error_message[0]);
            fmt.printf(string(error_message[0..<len(error_message)-1])); 

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
        ShaderSource(shader_id, 1, ^^byte(&shader_code), nil);
        CompileShader(shader_id);

        if (check_error(shader_id, COMPILE_STATUS, GetShaderiv, GetShaderInfoLog)) {
            return 0, false;
        }

        return shader_id, true;
    }

    compile_shader_from_string :: proc(shader_code: string, shader_type: i32) -> (u32, bool) {

        shader_id := CreateShader(shader_type);
        ShaderSource(shader_id, 1, ^^byte(&shader_code), nil);
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

	vertex_shader_id, fragment_shader_id: u32;
    ok1, ok2: bool;
    if vertex_shader_filename == "" {
    	vertex_shader_id, ok1 = compile_shader_from_string(vertex_shader_source, VERTEX_SHADER);	
    } else {
    	vertex_shader_id, ok1 = compile_shader_from_file(vertex_shader_filename, VERTEX_SHADER);	
    }
    defer DeleteShader(vertex_shader_id);

    if fragment_shader_filename == "" {
    	fragment_shader_id, ok2 = compile_shader_from_string(fragment_shader_source, FRAGMENT_SHADER);	
    } else {
    	fragment_shader_id, ok2 = compile_shader_from_file(fragment_shader_filename, FRAGMENT_SHADER);	
    }
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

// Hard coded for practical purposes. Identical copies are located in extra/
// Un case you want to use modified shaders, call init() manually with the appropriate filenames
vertex_shader_source := `
#version 330 core

layout(location = 0) in vec2 vertexPosition;
layout(location = 1) in vec4 instanceGlyph;

uniform sampler2D sampler_font;
uniform sampler2D sampler_meta;

uniform float offset_firstline; // ascent - descent - linegap/2
uniform float scale_factor;     // scaling factor proportional to font size
uniform vec2 string_offset;     // offset of upper-left corner

uniform vec2 res_meta;   // 96x2 
uniform vec2 res_bitmap; // 512x256
uniform vec2 resolution; // screen resolution

out vec2 uv;
out float color_index; // for syntax highlighting

void main() {
    // (xoff, yoff, xoff2, yoff2), from second row of texture
    vec4 q2 = texture(sampler_meta, vec2((instanceGlyph.z + 0.5)/res_meta.x, 0.75))*res_bitmap.xyxy;

    vec2 p = vertexPosition*(q2.zw - q2.xy) + q2.xy; // offset and scale it properly relative to baseline
    p *= vec2(1.0, -1.0);                            // flip y, since texture is upside-down
    p.y -= offset_firstline;                         // make sure the upper-left corner of the string is in the upper-left corner of the screen
    p *= scale_factor;                               // scale relative to font size
    p += instanceGlyph.xy + string_offset;           // move glyph into the right position
    p *= 2.0/resolution;                             // to NDC
    p += vec2(-1.0, 1.0);                            // move to upper-left corner instead of center

    gl_Position = vec4(p, 0.0, 1.0);

    // (x0, y0, x1-x0, y1-y0), from first row of texture
    vec4 q = texture(sampler_meta, vec2((instanceGlyph.z + 0.5)/res_meta.x, 0.25));

    // send the correct uv's in the font atlas to the fragment shader
    uv = q.xy + vertexPosition*q.zw;
    color_index = instanceGlyph.w;
}`;

fragment_shader_source := `
#version 330 core

in vec2 uv;
in float color_index;

uniform sampler2D sampler_font;
uniform sampler1D sampler_colors;

uniform float num_colors;
uniform vec2 res_bitmap;

out vec4 color;

void main()
{
    vec3 col = texture(sampler_colors, (color_index+0.5)/num_colors).rgb;
    float s0 = texture(sampler_font, uv + 0.0*vec2( 0.5,  0.5)/res_bitmap).r; 
	color = vec4(col, s0);
}`;
