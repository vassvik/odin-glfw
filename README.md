# odin-glfw

[Odin](https://github.com/gingerBill/Odin) bindings to GLFW 3.2.1. 

`odin-glfw` is not intended as an OpenGL library, so only the bare minimal is included for illustrational purposes. It is at the moment only intended as a binding library. It therefore doesn't wrap it therefore doesn't use Odin constructs where possible. This might be changed in the future. 

Contains 3 example programs:
 - `example_minimal.odin`: Creates a blank window only. Great as a minimal template for new OpenGL projects. 
 - `example_mandelbrot.odin`: Classic 2D example: the Mandelbrot set, but with a twist. Essentially a bare minimum OpenGL example.
 - `example_cube.odin`: Classic 3D example: A single rotating cube. Shows simple camera controls. NOTE: Uses +Z up. 

All examples only depend on glfw.odin, and each will grab the OpenGL function pointers they need using `glfwGetProcAddress`.

Comes bundled with the GLFW .dll and import .lib (for Windows). Linux only requires libglfw3.so to be available in the library path. 

Works in Windows and Linux as of the 21st of June, on commit `264ca00db72f56e2af8242a90e35a49b6ae13f86`. Should also work on MacOS. 

