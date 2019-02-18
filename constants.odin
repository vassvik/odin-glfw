package glfw

import bindings "bindings"

using Version_Number :: enum {
	VERSION_MAJOR = bindings.VERSION_MAJOR,
	VERSION_MINOR = bindings.VERSION_MINOR,
	VERSION_REVISION = bindings.VERSION_REVISION,
}

using Boolean_State :: enum {
	TRUE = bindings.TRUE,
	FALSE = bindings.FALSE,
}

using Key_State :: enum {
	RELEASE = bindings.RELEASE,
	PRESS = bindings.PRESS,
	REPEAT = bindings.REPEAT,
}

Button_State :: Key_State;

using Joystick_Hat :: enum u8 {
	HAT_CENTERED = bindings.HAT_CENTERED,
	HAT_UP = bindings.HAT_UP,
	HAT_RIGHT = bindings.HAT_RIGHT,
	HAT_DOWN = bindings.HAT_DOWN,
	HAT_LEFT = bindings.HAT_LEFT,
	HAT_RIGHT_UP = bindings.HAT_RIGHT_UP,
	HAT_RIGHT_DOWN = bindings.HAT_RIGHT_DOWN,
	HAT_LEFT_UP = bindings.HAT_LEFT_UP,
	HAT_LEFT_DOWN = bindings.HAT_LEFT_DOWN,
}

using Key :: enum {
	/* The unknown key */
	KEY_UNKNOWN = bindings.KEY_UNKNOWN,

	/** Printable keys **/

	/* Named printable keys */
	KEY_SPACE = bindings.KEY_SPACE,
	KEY_APOSTROPHE = bindings.KEY_APOSTROPHE,
	KEY_COMMA = bindings.KEY_COMMA,
	KEY_MINUS = bindings.KEY_MINUS,
	KEY_PERIOD = bindings.KEY_PERIOD,
	KEY_SLASH = bindings.KEY_SLASH,
	KEY_SEMICOLON = bindings.KEY_SEMICOLON,
	KEY_EQUAL = bindings.KEY_EQUAL,
	KEY_LEFT_BRACKET = bindings.KEY_LEFT_BRACKET,
	KEY_BACKSLASH = bindings.KEY_BACKSLASH,
	KEY_RIGHT_BRACKET = bindings.KEY_RIGHT_BRACKET,
	KEY_GRAVE_ACCENT = bindings.KEY_GRAVE_ACCENT,
	KEY_WORLD_1 = bindings.KEY_WORLD_1,
	KEY_WORLD_2 = bindings.KEY_WORLD_2,

	/* Alphanumeric characters */
	KEY_0 = bindings.KEY_0,
	KEY_1 = bindings.KEY_1,
	KEY_2 = bindings.KEY_2,
	KEY_3 = bindings.KEY_3,
	KEY_4 = bindings.KEY_4,
	KEY_5 = bindings.KEY_5,
	KEY_6 = bindings.KEY_6,
	KEY_7 = bindings.KEY_7,
	KEY_8 = bindings.KEY_8,
	KEY_9 = bindings.KEY_9,

	KEY_A = bindings.KEY_A,
	KEY_B = bindings.KEY_B,
	KEY_C = bindings.KEY_C,
	KEY_D = bindings.KEY_D,
	KEY_E = bindings.KEY_E,
	KEY_F = bindings.KEY_F,
	KEY_G = bindings.KEY_G,
	KEY_H = bindings.KEY_H,
	KEY_I = bindings.KEY_I,
	KEY_J = bindings.KEY_J,
	KEY_K = bindings.KEY_K,
	KEY_L = bindings.KEY_L,
	KEY_M = bindings.KEY_M,
	KEY_N = bindings.KEY_N,
	KEY_O = bindings.KEY_O,
	KEY_P = bindings.KEY_P,
	KEY_Q = bindings.KEY_Q,
	KEY_R = bindings.KEY_R,
	KEY_S = bindings.KEY_S,
	KEY_T = bindings.KEY_T,
	KEY_U = bindings.KEY_U,
	KEY_V = bindings.KEY_V,
	KEY_W = bindings.KEY_W,
	KEY_X = bindings.KEY_X,
	KEY_Y = bindings.KEY_Y,
	KEY_Z = bindings.KEY_Z,


	/** Function keys **/

	/* Named non-printable keys */
	KEY_ESCAPE = bindings.KEY_ESCAPE,
	KEY_ENTER = bindings.KEY_ENTER,
	KEY_TAB = bindings.KEY_TAB,
	KEY_BACKSPACE = bindings.KEY_BACKSPACE,
	KEY_INSERT = bindings.KEY_INSERT,
	KEY_DELETE = bindings.KEY_DELETE,
	KEY_RIGHT = bindings.KEY_RIGHT,
	KEY_LEFT = bindings.KEY_LEFT,
	KEY_DOWN = bindings.KEY_DOWN,
	KEY_UP = bindings.KEY_UP,
	KEY_PAGE_UP = bindings.KEY_PAGE_UP,
	KEY_PAGE_DOWN = bindings.KEY_PAGE_DOWN,
	KEY_HOME = bindings.KEY_HOME,
	KEY_END = bindings.KEY_END,
	KEY_CAPS_LOCK = bindings.KEY_CAPS_LOCK,
	KEY_SCROLL_LOCK = bindings.KEY_SCROLL_LOCK,
	KEY_NUM_LOCK = bindings.KEY_NUM_LOCK,
	KEY_PRINT_SCREEN = bindings.KEY_PRINT_SCREEN,
	KEY_PAUSE = bindings.KEY_PAUSE,

	/* Function keys */
	KEY_F1 = bindings.KEY_F1,
	KEY_F2 = bindings.KEY_F2,
	KEY_F3 = bindings.KEY_F3,
	KEY_F4 = bindings.KEY_F4,
	KEY_F5 = bindings.KEY_F5,
	KEY_F6 = bindings.KEY_F6,
	KEY_F7 = bindings.KEY_F7,
	KEY_F8 = bindings.KEY_F8,
	KEY_F9 = bindings.KEY_F9,
	KEY_F10 = bindings.KEY_F10,
	KEY_F11 = bindings.KEY_F11,
	KEY_F12 = bindings.KEY_F12,
	KEY_F13 = bindings.KEY_F13,
	KEY_F14 = bindings.KEY_F14,
	KEY_F15 = bindings.KEY_F15,
	KEY_F16 = bindings.KEY_F16,
	KEY_F17 = bindings.KEY_F17,
	KEY_F18 = bindings.KEY_F18,
	KEY_F19 = bindings.KEY_F19,
	KEY_F20 = bindings.KEY_F20,
	KEY_F21 = bindings.KEY_F21,
	KEY_F22 = bindings.KEY_F22,
	KEY_F23 = bindings.KEY_F23,
	KEY_F24 = bindings.KEY_F24,
	KEY_F25 = bindings.KEY_F25,

	/* Keypad numbers */
	KEY_KP_0 = bindings.KEY_KP_0,
	KEY_KP_1 = bindings.KEY_KP_1,
	KEY_KP_2 = bindings.KEY_KP_2,
	KEY_KP_3 = bindings.KEY_KP_3,
	KEY_KP_4 = bindings.KEY_KP_4,
	KEY_KP_5 = bindings.KEY_KP_5,
	KEY_KP_6 = bindings.KEY_KP_6,
	KEY_KP_7 = bindings.KEY_KP_7,
	KEY_KP_8 = bindings.KEY_KP_8,
	KEY_KP_9 = bindings.KEY_KP_9,

	/* Keypad named function keys */
	KEY_KP_DECIMAL = bindings.KEY_KP_DECIMAL,
	KEY_KP_DIVIDE = bindings.KEY_KP_DIVIDE,
	KEY_KP_MULTIPLY = bindings.KEY_KP_MULTIPLY,
	KEY_KP_SUBTRACT = bindings.KEY_KP_SUBTRACT,
	KEY_KP_ADD = bindings.KEY_KP_ADD,
	KEY_KP_ENTER = bindings.KEY_KP_ENTER,
	KEY_KP_EQUAL = bindings.KEY_KP_EQUAL,

	/* Modifier keys */
	KEY_LEFT_SHIFT = bindings.KEY_LEFT_SHIFT,
	KEY_LEFT_CONTROL = bindings.KEY_LEFT_CONTROL,
	KEY_LEFT_ALT = bindings.KEY_LEFT_ALT,
	KEY_LEFT_SUPER = bindings.KEY_LEFT_SUPER,
	KEY_RIGHT_SHIFT = bindings.KEY_RIGHT_SHIFT,
	KEY_RIGHT_CONTROL = bindings.KEY_RIGHT_CONTROL,
	KEY_RIGHT_ALT = bindings.KEY_RIGHT_ALT,
	KEY_RIGHT_SUPER = bindings.KEY_RIGHT_SUPER,
	KEY_MENU = bindings.KEY_MENU,

	KEY_LAST = bindings.KEY_LAST,
}

using Modifier :: enum {
	/* Bitmask for modifier keys */
	MOD_SHIFT = bindings.MOD_SHIFT,
	MOD_CONTROL = bindings.MOD_CONTROL,
	MOD_ALT = bindings.MOD_ALT,
	MOD_SUPER = bindings.MOD_SUPER,
	MOD_CAPS_LOCK = bindings.MOD_CAPS_LOCK,
	MOD_NUM_LOCK = bindings.MOD_NUM_LOCK,
}

using Mouse_Button :: enum {
	/* Mouse buttons */
	MOUSE_BUTTON_1 = bindings.MOUSE_BUTTON_1,
	MOUSE_BUTTON_2 = bindings.MOUSE_BUTTON_2,
	MOUSE_BUTTON_3 = bindings.MOUSE_BUTTON_3,
	MOUSE_BUTTON_4 = bindings.MOUSE_BUTTON_4,
	MOUSE_BUTTON_5 = bindings.MOUSE_BUTTON_5,
	MOUSE_BUTTON_6 = bindings.MOUSE_BUTTON_6,
	MOUSE_BUTTON_7 = bindings.MOUSE_BUTTON_7,
	MOUSE_BUTTON_8 = bindings.MOUSE_BUTTON_8,

	// TODO: does this work?
	/* Mousebutton aliases */
	MOUSE_BUTTON_LAST = bindings.MOUSE_BUTTON_LAST,
	MOUSE_BUTTON_LEFT = bindings.MOUSE_BUTTON_LEFT,
	MOUSE_BUTTON_RIGHT = bindings.MOUSE_BUTTON_RIGHT,
	MOUSE_BUTTON_MIDDLE = bindings.MOUSE_BUTTON_MIDDLE,
}

using Joystick :: enum {
	/* Joystick buttons */
	JOYSTICK_1 = bindings.JOYSTICK_1,
	JOYSTICK_2 = bindings.JOYSTICK_2,
	JOYSTICK_3 = bindings.JOYSTICK_3,
	JOYSTICK_4 = bindings.JOYSTICK_4,
	JOYSTICK_5 = bindings.JOYSTICK_5,
	JOYSTICK_6 = bindings.JOYSTICK_6,
	JOYSTICK_7 = bindings.JOYSTICK_7,
	JOYSTICK_8 = bindings.JOYSTICK_8,
	JOYSTICK_9 = bindings.JOYSTICK_9,
	JOYSTICK_10 = bindings.JOYSTICK_10,
	JOYSTICK_11 = bindings.JOYSTICK_11,
	JOYSTICK_12 = bindings.JOYSTICK_12,
	JOYSTICK_13 = bindings.JOYSTICK_13,
	JOYSTICK_14 = bindings.JOYSTICK_14,
	JOYSTICK_15 = bindings.JOYSTICK_15,
	JOYSTICK_16 = bindings.JOYSTICK_16,

	JOYSTICK_LAST = bindings.JOYSTICK_LAST,
}

using Gamepad_Button :: enum {
	/* Gamepad buttons */
	GAMEPAD_BUTTON_A = bindings.GAMEPAD_BUTTON_A,
	GAMEPAD_BUTTON_B = bindings.GAMEPAD_BUTTON_B,
	GAMEPAD_BUTTON_X = bindings.GAMEPAD_BUTTON_X,
	GAMEPAD_BUTTON_Y = bindings.GAMEPAD_BUTTON_Y,
	GAMEPAD_BUTTON_LEFT_BUMPER = bindings.GAMEPAD_BUTTON_LEFT_BUMPER,
	GAMEPAD_BUTTON_RIGHT_BUMPER = bindings.GAMEPAD_BUTTON_RIGHT_BUMPER,
	GAMEPAD_BUTTON_BACK = bindings.GAMEPAD_BUTTON_BACK,
	GAMEPAD_BUTTON_START = bindings.GAMEPAD_BUTTON_START,
	GAMEPAD_BUTTON_GUIDE = bindings.GAMEPAD_BUTTON_GUIDE,
	GAMEPAD_BUTTON_LEFT_THUMB = bindings.GAMEPAD_BUTTON_LEFT_THUMB,
	GAMEPAD_BUTTON_RIGHT_THUMB = bindings.GAMEPAD_BUTTON_RIGHT_THUMB,
	GAMEPAD_BUTTON_DPAD_UP = bindings.GAMEPAD_BUTTON_DPAD_UP,
	GAMEPAD_BUTTON_DPAD_RIGHT = bindings.GAMEPAD_BUTTON_DPAD_RIGHT,
	GAMEPAD_BUTTON_DPAD_DOWN = bindings.GAMEPAD_BUTTON_DPAD_DOWN,
	GAMEPAD_BUTTON_DPAD_LEFT = bindings.GAMEPAD_BUTTON_DPAD_LEFT,
	GAMEPAD_BUTTON_LAST = bindings.GAMEPAD_BUTTON_LAST,
	GAMEPAD_BUTTON_CROSS = bindings.GAMEPAD_BUTTON_CROSS,
	GAMEPAD_BUTTON_CIRCLE = bindings.GAMEPAD_BUTTON_CIRCLE,
	GAMEPAD_BUTTON_SQUARE = bindings.GAMEPAD_BUTTON_SQUARE,
	GAMEPAD_BUTTON_TRIANGLE = bindings.GAMEPAD_BUTTON_TRIANGLE,
}

using Gamepad_Axes :: enum {
	/* Gamepad axes */
	GAMEPAD_AXIS_LEFT_X = bindings.GAMEPAD_AXIS_LEFT_X,
	GAMEPAD_AXIS_LEFT_Y = bindings.GAMEPAD_AXIS_LEFT_Y,
	GAMEPAD_AXIS_RIGHT_X = bindings.GAMEPAD_AXIS_RIGHT_X,
	GAMEPAD_AXIS_RIGHT_Y = bindings.GAMEPAD_AXIS_RIGHT_Y,
	GAMEPAD_AXIS_LEFT_TRIGGER = bindings.GAMEPAD_AXIS_LEFT_TRIGGER,
	GAMEPAD_AXIS_RIGHT_TRIGGER = bindings.GAMEPAD_AXIS_RIGHT_TRIGGER,
	GAMEPAD_AXIS_LAST = bindings.GAMEPAD_AXIS_LAST,
}

using Error :: enum {
	/* Error constants */
	NO_ERROR = bindings.NO_ERROR,
	NOT_INITIALIZED = bindings.NOT_INITIALIZED,
	NO_CURRENT_CONTEXT = bindings.NO_CURRENT_CONTEXT,
	INVALID_ENUM = bindings.INVALID_ENUM,
	INVALID_VALUE = bindings.INVALID_VALUE,
	OUT_OF_MEMORY = bindings.OUT_OF_MEMORY,
	API_UNAVAILABLE = bindings.API_UNAVAILABLE,
	VERSION_UNAVAILABLE = bindings.VERSION_UNAVAILABLE,
	PLATFORM_ERROR = bindings.PLATFORM_ERROR,
	FORMAT_UNAVAILABLE = bindings.FORMAT_UNAVAILABLE,
	NO_WINDOW_CONTEXT = bindings.NO_WINDOW_CONTEXT,
}

using Window_Attribute :: enum {
	// TODO: are these organized well?

	/* Window attributes */
	FOCUSED = bindings.FOCUSED,
	ICONIFIED = bindings.ICONIFIED,
	RESIZABLE = bindings.RESIZABLE,
	VISIBLE = bindings.VISIBLE,
	DECORATED = bindings.DECORATED,
	AUTO_ICONIFY = bindings.AUTO_ICONIFY,
	FLOATING = bindings.FLOATING,
	MAXIMIZED = bindings.MAXIMIZED,
	CENTER_CURSOR = bindings.CENTER_CURSOR,
	TRANSPARENT_FRAMEBUFFER = bindings.TRANSPARENT_FRAMEBUFFER,
	HOVERED = bindings.HOVERED,
	FOCUS_ON_SHOW = bindings.FOCUS_ON_SHOW,

	/* Pixel window attributes */
	RED_BITS = bindings.RED_BITS,
	GREEN_BITS = bindings.GREEN_BITS,
	BLUE_BITS = bindings.BLUE_BITS,
	ALPHA_BITS = bindings.ALPHA_BITS,
	DEPTH_BITS = bindings.DEPTH_BITS,
	STENCIL_BITS = bindings.STENCIL_BITS,
	ACCUM_RED_BITS = bindings.ACCUM_RED_BITS,
	ACCUM_GREEN_BITS = bindings.ACCUM_GREEN_BITS,
	ACCUM_BLUE_BITS = bindings.ACCUM_BLUE_BITS,
	ACCUM_ALPHA_BITS = bindings.ACCUM_ALPHA_BITS,
	AUX_BUFFERS = bindings.AUX_BUFFERS,
	STEREO = bindings.STEREO,
	SAMPLES = bindings.SAMPLES,
	SRGB_CAPABLE = bindings.SRGB_CAPABLE,
	REFRESH_RATE = bindings.REFRESH_RATE,
	DOUBLEBUFFER = bindings.DOUBLEBUFFER,

	/* Context window attributes */
	CLIENT_API = bindings.CLIENT_API,
	CONTEXT_VERSION_MAJOR = bindings.CONTEXT_VERSION_MAJOR,
	CONTEXT_VERSION_MINOR = bindings.CONTEXT_VERSION_MINOR,
	CONTEXT_REVISION = bindings.CONTEXT_REVISION,
	CONTEXT_ROBUSTNESS = bindings.CONTEXT_ROBUSTNESS,
	OPENGL_FORWARD_COMPAT = bindings.OPENGL_FORWARD_COMPAT,
	OPENGL_DEBUG_CONTEXT = bindings.OPENGL_DEBUG_CONTEXT,
	OPENGL_PROFILE = bindings.OPENGL_PROFILE,
	CONTEXT_RELEASE_BEHAVIOR = bindings.CONTEXT_RELEASE_BEHAVIOR,
	CONTEXT_NO_ERROR = bindings.CONTEXT_NO_ERROR,
	CONTEXT_CREATION_API = bindings.CONTEXT_CREATION_API,
	SCALE_TO_MONITOR = bindings.SCALE_TO_MONITOR,

	/* Cross platform stuff */
	COCOA_RETINA_FRAMEBUFFER = bindings.COCOA_RETINA_FRAMEBUFFER,
	COCOA_FRAME_NAME = bindings.COCOA_FRAME_NAME,
	COCOA_GRAPHICS_SWITCHING = bindings.COCOA_GRAPHICS_SWITCHING,
	X11_CLASS_NAME = bindings.X11_CLASS_NAME,
	X11_INSTANCE_NAME = bindings.X11_INSTANCE_NAME,
}

using API :: enum {
	/* APIs */
	NO_API = bindings.NO_API,
	OPENGL_API = bindings.OPENGL_API,
	OPENGL_ES_API = bindings.OPENGL_ES_API,
}

using Robustness :: enum {
	/* Robustness? */
	NO_ROBUSTNESS = bindings.NO_ROBUSTNESS,
	NO_RESET_NOTIFICATION = bindings.NO_RESET_NOTIFICATION,
	LOSE_CONTEXT_ON_RESET = bindings.LOSE_CONTEXT_ON_RESET,
}

using OpenGL_Profile :: enum {
	/* OpenGL Profiles */
	OPENGL_ANY_PROFILE = bindings.OPENGL_ANY_PROFILE,
	OPENGL_CORE_PROFILE = bindings.OPENGL_CORE_PROFILE,
	OPENGL_COMPAT_PROFILE = bindings.OPENGL_COMPAT_PROFILE,
}

using Input_Mode :: enum {	
	/* Cursor draw state and whether keys are sticky */
	CURSOR = bindings.CURSOR,
	STICKY_KEYS = bindings.STICKY_KEYS,
	STICKY_MOUSE_BUTTONS = bindings.STICKY_MOUSE_BUTTONS,
	LOCK_KEY_MODS = bindings.LOCK_KEY_MODS,
}

using Cursor_State :: enum {
	/* Cursor draw state */
	CURSOR_NORMAL = bindings.CURSOR_NORMAL,
	CURSOR_HIDDEN = bindings.CURSOR_HIDDEN,
	CURSOR_DISABLED = bindings.CURSOR_DISABLED,
}

using Behavior :: enum {

	/* Behavior? */
	ANY_RELEASE_BEHAVIOR = bindings.ANY_RELEASE_BEHAVIOR,
	RELEASE_BEHAVIOR_FLUSH = bindings.RELEASE_BEHAVIOR_FLUSH,
	RELEASE_BEHAVIOR_NONE = bindings.RELEASE_BEHAVIOR_NONE,
}

using Context_API :: enum {

	/* Context API ? */
	NATIVE_CONTEXT_API = bindings.NATIVE_CONTEXT_API,
	EGL_CONTEXT_API = bindings.EGL_CONTEXT_API,
	OSMESA_CONTEXT_API = bindings.OSMESA_CONTEXT_API,
}

using Cursor_Shape :: enum {

	/* Types of cursors */
	ARROW_CURSOR = bindings.ARROW_CURSOR,
	IBEAM_CURSOR = bindings.IBEAM_CURSOR,
	CROSSHAIR_CURSOR = bindings.CROSSHAIR_CURSOR,
	HAND_CURSOR = bindings.HAND_CURSOR,
	HRESIZE_CURSOR = bindings.HRESIZE_CURSOR,
	VRESIZE_CURSOR = bindings.VRESIZE_CURSOR,
}

using Joystick_State :: enum {
	/* Joystick? */
	CONNECTED = bindings.CONNECTED,
	DISCONNECTED = bindings.DISCONNECTED,
}

using Init_Hint :: enum {
	/*  macOS specific init hint. */
	JOYSTICK_HAT_BUTTONS = bindings.JOYSTICK_HAT_BUTTONS,
	COCOA_CHDIR_RESOURCES = bindings.COCOA_CHDIR_RESOURCES,
	COCOA_MENUBAR = bindings.COCOA_MENUBAR,
}

using Misc :: enum {
	/*  */
	DONT_CARE = bindings.DONT_CARE,
}