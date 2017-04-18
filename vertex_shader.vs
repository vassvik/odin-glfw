#version 330 core

layout(location = 0) in vec2 vertexPosition;
layout(location = 1) in vec2 vertexUV;

out vec2 uv;

void main()
{
    gl_Position = vec4(0.5*vertexPosition, 0.0, 1.0);
    uv = vertexUV;
}
