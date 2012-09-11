#version 420
 
layout (location = 0) in vec3 position;
uniform float time;
uniform mat4 perspective;
 
void main(void) {
  vec4 offset = vec4(sin(time) * 0.75f, cos(time * 0.7f) * 0.75f, sin(time * 0.3f), 0.f);
  vec4 camera = vec4(position, 1.f) + vec4(offset);

  gl_Position = perspective * camera;
}
