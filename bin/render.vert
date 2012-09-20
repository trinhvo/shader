#version 420
 
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;

out vec3 vertexPosition;
out vec3 vertexNormal;

uniform mat4 perspective;
uniform vec3 camera;

void main(void) {
  vec4 finalPosition = vec4(position, 1.f) - vec4(camera, 0.f);

  gl_Position = perspective * finalPosition;
  vertexNormal = (perspective * vec4(normal, 0.f)).xyz;
  vertexPosition = position;
}