# odin-glfw

[Odin](https://github.com/gingerBill/Odin) bindings to GLFW 3.2.1 (at least)

odin-glfw contain bindings to the C library, in addition to a bunch of additional wrappers and utility functions.

#### NOTE: Requires binaries to be available in system paths (in linux) or bundled with the exe (in windows).

#### NOTE: It is recommended to put this into the shared collection:
```
cd Odin/shared
git clone https://github.com/vassvik/odin-glfw.git
```


#### Usage:

GLFW is primarily used to create a window, create an opengl context, and to handle input. GLFW also works for Vulkan. 

To use OpenGL functions you need an OpenGL function loader. See [https://github.com/vassvik/odin-gl](https://github.com/vassvik/odin-gl) for one such loader. 

This library is used in [https://github.com/vassvik/odin-gl_font](https://github.com/vassvik/odin-gl_font) to perform simple text rendering. Take a look.