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
}