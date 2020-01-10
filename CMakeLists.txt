cmake_minimum_required (VERSION 3.0)
cmake_policy(VERSION 3.0)

project (Quadtree_LOD)


if(MSVC)
  add_definitions(/DNOMINMAX)
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic -std=c++11")
endif()

#########################################################################
# On Ubuntu:
# SDL:    sudo apt-get install libsdl1.2-dev libglm-dev
#########################################################################

#########################################################################
# On Mac OSX:
# brew install cmake sdl glm
#########################################################################

find_package (PkgConfig REQUIRED)
find_package (OpenGL REQUIRED)

if(WIN32)
  include_directories(Vendor/include)
  link_directories(Vendor/lib)

  set(LIBS mingw32 SDLmain SDL glew32s opengl32 glu32 gdi32)

else(WIN32)
  find_package(GLEW REQUIRED STATIC)
  find_package(SDL REQUIRED STATIC)
  find_package(GLUT REQUIRED STATIC)
endif(WIN32)

if(APPLE)
  add_definitions(-DGL_SILENCE_DEPRECATION)

  include_directories(
    /usr/local/include
    ${OPENGL_INCLUDE_DIR}
    ${GLUT_INCLUDE_DIR}
    ${SDL_INCLUDE_DIR}
    Vendor/include
    # /System/Library/Frameworks
  )

  link_directories(/usr/local/lib/ /opt/local/lib)

  find_library(COCOA_LIBRARY Cocoa REQUIRED)
  find_library(IOKIT_LIBRARY IOKit REQUIRED)
  find_library(COREVID_LIBRARY CoreVideo REQUIRED)

  set(LIBS  SDLmain
            ${SDL_LIBRARY}
            ${OPENGL_LIBRARIES}
            ${GLUT_LIBRARIES}
            ${GLEW_LIBRARY}
            ${COCOA_LIBRARY}
            ${COREVID_LIBRARY}
            ${IOKIT_LIBRARY})

elseif(UNIX AND NOT APPLE)
  add_definitions(${OPENGL_DEFINITIONS})

  set(LIBS  SDLmain
            ${SDL_LIBRARY}
            ${OPENGL_LIBRARIES}
            ${GLUT_LIBRARIES}
            ${GLEW_LIBRARY}
            Xxf86vm pthread Xrandr Xinerama Xi Xcursor)

endif(APPLE)


file(GLOB_RECURSE PROJ_SOURCES src/*.h src/*.hpp src/*.cpp src/*.c)

add_executable(${PROJECT_NAME} ${PROJ_SOURCES})

target_link_libraries(${PROJECT_NAME} ${LIBS})

set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_custom_command(
  TARGET ${PROJECT_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/data $<TARGET_FILE_DIR:${PROJECT_NAME}>/
  DEPENDS ${PROJECT_NAME}
)