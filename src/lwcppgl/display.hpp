#ifndef LWCPPGL_DISPLAY_HPP
#define LWCPPGL_DISPLAY_HPP

#include <cstdio>
#include <cstdlib>

#if defined(__APPLE__)
#include <OpenGL/glu.h>
#else
#include <GL/gl.h>
#endif

#include <SDL/SDL.h>
#include <SDL/SDL_opengl.h>

#include <GL/glext.h>

#include "keyboard.hpp"

class Display {
  public:
    static GLvoid create(GLuint, GLuint);
    static GLvoid update();
    static GLuint shaders(const char *, const char *);

  private:
    static GLchar *source(const GLchar *);
};

#endif // LWCPPGL_DISPLAY_HPP
