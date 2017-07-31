# odin-glfw

[Odin](https://github.com/gingerBill/Odin) bindings to GLFW 3.2.1 (at least)

odin-glfw only contain bindings to the C library, in addition to a few additional wrappers and utility functions (vararg window title and frame timings)

Contains 3 example programs:
 - `example_minimal.odin`: Creates a blank window only. Great as a minimal template for new OpenGL projects. 
 - `example_mandelbrot.odin`: 2D OpenGL example: the Mandelbrot set, but with a twist. Essentially a bare minimum OpenGL example.
 - `example_cube.odin`: 3D OpenGL example: A single rotating cube. Shows simple camera controls. NOTE: Uses +Z up. 

The examples only depend on glfw.odin, and each will grab the OpenGL function pointers they need using `glfwGetProcAddress`.

No longer comes bundled with the GLFW .dll and import .lib (for Windows), so make sure you grab the latest binaries from [http://www.glfw.org](http://www.glfw.org) (64 bit VS2015). Linux only requires libglfw3.so to be available in the system library path (defined in `/etc/ld.so.conf.d/`).

