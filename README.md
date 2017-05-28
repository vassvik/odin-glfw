# odin-glfw

[Odin](https://github.com/gingerBill/Odin) bindings to GLFW 3.2.1. 

Contains 4 example programs:
 - `example_minimal.odin`: Creates a blank window only. Great as a template for new OpenGL projects. 
 - `example_triangle_2D.odin`: Draws a single rotating triangle in NDC coordinates, so no transformations. Essentially a bare minimum OpenGL example.
 - `example_bendable_line.odin`: Draws a stretching line segment in NDC coordinates. Another bare minimum OpenGL example.
 - `example_triangle_3D.odin`: Draws a single rotating triangle in 3D, using perspective projection. Shows simple camera controls. NOTE: Uses +Z up. 

All examples should be standalone, and each will grab the OpenGL function pointers they need using `glfwGetProcAddress`.

Comes bundled with the GLFW .dll and import .lib (for Windows). Linux only requires libglfw3.so to be available in the library path. 

Works in Windows as of the 28th of May, on commit `f4924e39d487f95bbfbfbc83dd0ae237923505ae`. Should also work in Linux, but this is untested at the moment. 

