cmake_minimum_required(VERSION 3.6)
project(heightfield_generator)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -lGL -lGLU -lglut")

set(SOURCE_FILES main.cpp)
add_executable(heightfield_generator ${SOURCE_FILES})