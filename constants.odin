package glfw

import bindings "bindings"

Version_Number :: enum {
	VERSION_MAJOR = bindings.VERSION_MAJOR,
	VERSION_MINOR = bindings.VERSION_MINOR,
	VERSION_REVISION = bindings.VERSION_REVISION,
}
VERSION_MAJOR    :: Version_Number.VERSION_MAJOR;
VERSION_MINOR    :: Version_Number.VERSION_MINOR;
VERSION_REVISION :: Version_Number.VERSION_REVISION;

Boolean_State :: enum {
	TRUE = bindings.TRUE,
	FALSE = bindings.FALSE,
}
TRUE  :: Boolean_State.TRUE;
FALSE :: Boolean_State.FALSE;

Key_State :: enum {
	RELEASE = bindings.RELEASE,
	PRESS = bindings.PRESS,
	REPEAT = bindings.REPEAT,
}

RELEASE :: Key_State.RELEASE;
PRESS   :: Key_State.PRESS;
REPEAT  :: Key_State.REPEAT;

Button_State :: Key_State;

Joystick_Hat :: enum u8 {
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

HAT_CENTERED   :: Joystick_Hat.HAT_CENTERED;
HAT_UP         :: Joystick_Hat.HAT_UP;
HAT_RIGHT      :: Joystick_Hat.HAT_RIGHT;
HAT_DOWN       :: Joystick_Hat.HAT_DOWN;
HAT_LEFT       :: Joystick_Hat.HAT_LEFT;
HAT_RIGHT_UP   :: Joystick_Hat.HAT_RIGHT_UP;
HAT_RIGHT_DOWN :: Joystick_Hat.HAT_RIGHT_DOWN;
HAT_LEFT_UP    :: Joystick_Hat.HAT_LEFT_UP;
HAT_LEFT_DOWN  :: Joystick_Hat.HAT_LEFT_DOWN;


Key :: enum {
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

KEY_UNKNOWN       :: Key.KEY_UNKNOWN;
KEY_SPACE         :: Key.KEY_SPACE;
KEY_APOSTROPHE    :: Key.KEY_APOSTROPHE;
KEY_COMMA         :: Key.KEY_COMMA;
KEY_MINUS         :: Key.KEY_MINUS;
KEY_PERIOD        :: Key.KEY_PERIOD;
KEY_SLASH         :: Key.KEY_SLASH;
KEY_SEMICOLON     :: Key.KEY_SEMICOLON;
KEY_EQUAL         :: Key.KEY_EQUAL;
KEY_LEFT_BRACKET  :: Key.KEY_LEFT_BRACKET;
KEY_BACKSLASH     :: Key.KEY_BACKSLASH;
KEY_RIGHT_BRACKET :: Key.KEY_RIGHT_BRACKET;
KEY_GRAVE_ACCENT  :: Key.KEY_GRAVE_ACCENT;
KEY_WORLD_1       :: Key.KEY_WORLD_1;
KEY_WORLD_2       :: Key.KEY_WORLD_2;
KEY_0             :: Key.KEY_0;
KEY_1             :: Key.KEY_1;
KEY_2             :: Key.KEY_2;
KEY_3             :: Key.KEY_3;
KEY_4             :: Key.KEY_4;
KEY_5             :: Key.KEY_5;
KEY_6             :: Key.KEY_6;
KEY_7             :: Key.KEY_7;
KEY_8             :: Key.KEY_8;
KEY_9             :: Key.KEY_9;
KEY_A             :: Key.KEY_A;
KEY_B             :: Key.KEY_B;
KEY_C             :: Key.KEY_C;
KEY_D             :: Key.KEY_D;
KEY_E             :: Key.KEY_E;
KEY_F             :: Key.KEY_F;
KEY_G             :: Key.KEY_G;
KEY_H             :: Key.KEY_H;
KEY_I             :: Key.KEY_I;
KEY_J             :: Key.KEY_J;
KEY_K             :: Key.KEY_K;
KEY_L             :: Key.KEY_L;
KEY_M             :: Key.KEY_M;
KEY_N             :: Key.KEY_N;
KEY_O             :: Key.KEY_O;
KEY_P             :: Key.KEY_P;
KEY_Q             :: Key.KEY_Q;
KEY_R             :: Key.KEY_R;
KEY_S             :: Key.KEY_S;
KEY_T             :: Key.KEY_T;
KEY_U             :: Key.KEY_U;
KEY_V             :: Key.KEY_V;
KEY_W             :: Key.KEY_W;
KEY_X             :: Key.KEY_X;
KEY_Y             :: Key.KEY_Y;
KEY_Z             :: Key.KEY_Z;
KEY_ESCAPE        :: Key.KEY_ESCAPE;
KEY_ENTER         :: Key.KEY_ENTER;
KEY_TAB           :: Key.KEY_TAB;
KEY_BACKSPACE     :: Key.KEY_BACKSPACE;
KEY_INSERT        :: Key.KEY_INSERT;
KEY_DELETE        :: Key.KEY_DELETE;
KEY_RIGHT         :: Key.KEY_RIGHT;
KEY_LEFT          :: Key.KEY_LEFT;
KEY_DOWN          :: Key.KEY_DOWN;
KEY_UP            :: Key.KEY_UP;
KEY_PAGE_UP       :: Key.KEY_PAGE_UP;
KEY_PAGE_DOWN     :: Key.KEY_PAGE_DOWN;
KEY_HOME          :: Key.KEY_HOME;
KEY_END           :: Key.KEY_END;
KEY_CAPS_LOCK     :: Key.KEY_CAPS_LOCK;
KEY_SCROLL_LOCK   :: Key.KEY_SCROLL_LOCK;
KEY_NUM_LOCK      :: Key.KEY_NUM_LOCK;
KEY_PRINT_SCREEN  :: Key.KEY_PRINT_SCREEN;
KEY_PAUSE         :: Key.KEY_PAUSE;
KEY_F1            :: Key.KEY_F1;
KEY_F2            :: Key.KEY_F2;
KEY_F3            :: Key.KEY_F3;
KEY_F4            :: Key.KEY_F4;
KEY_F5            :: Key.KEY_F5;
KEY_F6            :: Key.KEY_F6;
KEY_F7            :: Key.KEY_F7;
KEY_F8            :: Key.KEY_F8;
KEY_F9            :: Key.KEY_F9;
KEY_F10           :: Key.KEY_F10;
KEY_F11           :: Key.KEY_F11;
KEY_F12           :: Key.KEY_F12;
KEY_F13           :: Key.KEY_F13;
KEY_F14           :: Key.KEY_F14;
KEY_F15           :: Key.KEY_F15;
KEY_F16           :: Key.KEY_F16;
KEY_F17           :: Key.KEY_F17;
KEY_F18           :: Key.KEY_F18;
KEY_F19           :: Key.KEY_F19;
KEY_F20           :: Key.KEY_F20;
KEY_F21           :: Key.KEY_F21;
KEY_F22           :: Key.KEY_F22;
KEY_F23           :: Key.KEY_F23;
KEY_F24           :: Key.KEY_F24;
KEY_F25           :: Key.KEY_F25;
KEY_KP_0          :: Key.KEY_KP_0;
KEY_KP_1          :: Key.KEY_KP_1;
KEY_KP_2          :: Key.KEY_KP_2;
KEY_KP_3          :: Key.KEY_KP_3;
KEY_KP_4          :: Key.KEY_KP_4;
KEY_KP_5          :: Key.KEY_KP_5;
KEY_KP_6          :: Key.KEY_KP_6;
KEY_KP_7          :: Key.KEY_KP_7;
KEY_KP_8          :: Key.KEY_KP_8;
KEY_KP_9          :: Key.KEY_KP_9;
KEY_KP_DECIMAL    :: Key.KEY_KP_DECIMAL;
KEY_KP_DIVIDE     :: Key.KEY_KP_DIVIDE;
KEY_KP_MULTIPLY   :: Key.KEY_KP_MULTIPLY;
KEY_KP_SUBTRACT   :: Key.KEY_KP_SUBTRACT;
KEY_KP_ADD        :: Key.KEY_KP_ADD;
KEY_KP_ENTER      :: Key.KEY_KP_ENTER;
KEY_KP_EQUAL      :: Key.KEY_KP_EQUAL;
KEY_LEFT_SHIFT    :: Key.KEY_LEFT_SHIFT;
KEY_LEFT_CONTROL  :: Key.KEY_LEFT_CONTROL;
KEY_LEFT_ALT      :: Key.KEY_LEFT_ALT;
KEY_LEFT_SUPER    :: Key.KEY_LEFT_SUPER;
KEY_RIGHT_SHIFT   :: Key.KEY_RIGHT_SHIFT;
KEY_RIGHT_CONTROL :: Key.KEY_RIGHT_CONTROL;
KEY_RIGHT_ALT     :: Key.KEY_RIGHT_ALT;
KEY_RIGHT_SUPER   :: Key.KEY_RIGHT_SUPER;
KEY_MENU          :: Key.KEY_MENU;
KEY_LAST          :: Key.KEY_LAST;

Modifier :: enum {
	/* Bitmask for modifier keys */
	MOD_SHIFT = bindings.MOD_SHIFT,
	MOD_CONTROL = bindings.MOD_CONTROL,
	MOD_ALT = bindings.MOD_ALT,
	MOD_SUPER = bindings.MOD_SUPER,
	MOD_CAPS_LOCK = bindings.MOD_CAPS_LOCK,
	MOD_NUM_LOCK = bindings.MOD_NUM_LOCK,
}

MOD_SHIFT     :: Modifier.MOD_SHIFT;
MOD_CONTROL   :: Modifier.MOD_CONTROL;
MOD_ALT       :: Modifier.MOD_ALT;
MOD_SUPER     :: Modifier.MOD_SUPER;
MOD_CAPS_LOCK :: Modifier.MOD_CAPS_LOCK;
MOD_NUM_LOCK  :: Modifier.MOD_NUM_LOCK;

Mouse_Button :: enum {
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

MOUSE_BUTTON_1      :: Mouse_Button.MOUSE_BUTTON_1;
MOUSE_BUTTON_2      :: Mouse_Button.MOUSE_BUTTON_2;
MOUSE_BUTTON_3      :: Mouse_Button.MOUSE_BUTTON_3;
MOUSE_BUTTON_4      :: Mouse_Button.MOUSE_BUTTON_4;
MOUSE_BUTTON_5      :: Mouse_Button.MOUSE_BUTTON_5;
MOUSE_BUTTON_6      :: Mouse_Button.MOUSE_BUTTON_6;
MOUSE_BUTTON_7      :: Mouse_Button.MOUSE_BUTTON_7;
MOUSE_BUTTON_8      :: Mouse_Button.MOUSE_BUTTON_8;
MOUSE_BUTTON_LAST   :: Mouse_Button.MOUSE_BUTTON_LAST;
MOUSE_BUTTON_LEFT   :: Mouse_Button.MOUSE_BUTTON_LEFT;
MOUSE_BUTTON_RIGHT  :: Mouse_Button.MOUSE_BUTTON_RIGHT;
MOUSE_BUTTON_MIDDLE :: Mouse_Button.MOUSE_BUTTON_MIDDLE;


Joystick :: enum {
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

JOYSTICK_1    :: Joystick.JOYSTICK_1;
JOYSTICK_2    :: Joystick.JOYSTICK_2;
JOYSTICK_3    :: Joystick.JOYSTICK_3;
JOYSTICK_4    :: Joystick.JOYSTICK_4;
JOYSTICK_5    :: Joystick.JOYSTICK_5;
JOYSTICK_6    :: Joystick.JOYSTICK_6;
JOYSTICK_7    :: Joystick.JOYSTICK_7;
JOYSTICK_8    :: Joystick.JOYSTICK_8;
JOYSTICK_9    :: Joystick.JOYSTICK_9;
JOYSTICK_10   :: Joystick.JOYSTICK_10;
JOYSTICK_11   :: Joystick.JOYSTICK_11;
JOYSTICK_12   :: Joystick.JOYSTICK_12;
JOYSTICK_13   :: Joystick.JOYSTICK_13;
JOYSTICK_14   :: Joystick.JOYSTICK_14;
JOYSTICK_15   :: Joystick.JOYSTICK_15;
JOYSTICK_16   :: Joystick.JOYSTICK_16;
JOYSTICK_LAST :: Joystick.JOYSTICK_LAST;


Gamepad_Button :: enum {
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

GAMEPAD_BUTTON_A            :: Gamepad_Button.GAMEPAD_BUTTON_A;
GAMEPAD_BUTTON_B            :: Gamepad_Button.GAMEPAD_BUTTON_B;
GAMEPAD_BUTTON_X            :: Gamepad_Button.GAMEPAD_BUTTON_X;
GAMEPAD_BUTTON_Y            :: Gamepad_Button.GAMEPAD_BUTTON_Y;
GAMEPAD_BUTTON_LEFT_BUMPER  :: Gamepad_Button.GAMEPAD_BUTTON_LEFT_BUMPER;
GAMEPAD_BUTTON_RIGHT_BUMPER :: Gamepad_Button.GAMEPAD_BUTTON_RIGHT_BUMPER;
GAMEPAD_BUTTON_BACK         :: Gamepad_Button.GAMEPAD_BUTTON_BACK;
GAMEPAD_BUTTON_START        :: Gamepad_Button.GAMEPAD_BUTTON_START;
GAMEPAD_BUTTON_GUIDE        :: Gamepad_Button.GAMEPAD_BUTTON_GUIDE;
GAMEPAD_BUTTON_LEFT_THUMB   :: Gamepad_Button.GAMEPAD_BUTTON_LEFT_THUMB;
GAMEPAD_BUTTON_RIGHT_THUMB  :: Gamepad_Button.GAMEPAD_BUTTON_RIGHT_THUMB;
GAMEPAD_BUTTON_DPAD_UP      :: Gamepad_Button.GAMEPAD_BUTTON_DPAD_UP;
GAMEPAD_BUTTON_DPAD_RIGHT   :: Gamepad_Button.GAMEPAD_BUTTON_DPAD_RIGHT;
GAMEPAD_BUTTON_DPAD_DOWN    :: Gamepad_Button.GAMEPAD_BUTTON_DPAD_DOWN;
GAMEPAD_BUTTON_DPAD_LEFT    :: Gamepad_Button.GAMEPAD_BUTTON_DPAD_LEFT;
GAMEPAD_BUTTON_LAST         :: Gamepad_Button.GAMEPAD_BUTTON_LAST;
GAMEPAD_BUTTON_CROSS        :: Gamepad_Button.GAMEPAD_BUTTON_CROSS;
GAMEPAD_BUTTON_CIRCLE       :: Gamepad_Button.GAMEPAD_BUTTON_CIRCLE;
GAMEPAD_BUTTON_SQUARE       :: Gamepad_Button.GAMEPAD_BUTTON_SQUARE;
GAMEPAD_BUTTON_TRIANGLE     :: Gamepad_Button.GAMEPAD_BUTTON_TRIANGLE;

Gamepad_Axes :: enum {
	/* Gamepad axes */
	GAMEPAD_AXIS_LEFT_X = bindings.GAMEPAD_AXIS_LEFT_X,
	GAMEPAD_AXIS_LEFT_Y = bindings.GAMEPAD_AXIS_LEFT_Y,
	GAMEPAD_AXIS_RIGHT_X = bindings.GAMEPAD_AXIS_RIGHT_X,
	GAMEPAD_AXIS_RIGHT_Y = bindings.GAMEPAD_AXIS_RIGHT_Y,
	GAMEPAD_AXIS_LEFT_TRIGGER = bindings.GAMEPAD_AXIS_LEFT_TRIGGER,
	GAMEPAD_AXIS_RIGHT_TRIGGER = bindings.GAMEPAD_AXIS_RIGHT_TRIGGER,
	GAMEPAD_AXIS_LAST = bindings.GAMEPAD_AXIS_LAST,
}

GAMEPAD_AXIS_LEFT_X        :: Gamepad_Axes.GAMEPAD_AXIS_LEFT_X;
GAMEPAD_AXIS_LEFT_Y        :: Gamepad_Axes.GAMEPAD_AXIS_LEFT_Y;
GAMEPAD_AXIS_RIGHT_X       :: Gamepad_Axes.GAMEPAD_AXIS_RIGHT_X;
GAMEPAD_AXIS_RIGHT_Y       :: Gamepad_Axes.GAMEPAD_AXIS_RIGHT_Y;
GAMEPAD_AXIS_LEFT_TRIGGER  :: Gamepad_Axes.GAMEPAD_AXIS_LEFT_TRIGGER;
GAMEPAD_AXIS_RIGHT_TRIGGER :: Gamepad_Axes.GAMEPAD_AXIS_RIGHT_TRIGGER;
GAMEPAD_AXIS_LAST          :: Gamepad_Axes.GAMEPAD_AXIS_LAST;

Error :: enum {
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

NO_ERROR            :: Error.NO_ERROR;
NOT_INITIALIZED     :: Error.NOT_INITIALIZED;
NO_CURRENT_CONTEXT  :: Error.NO_CURRENT_CONTEXT;
INVALID_ENUM        :: Error.INVALID_ENUM;
INVALID_VALUE       :: Error.INVALID_VALUE;
OUT_OF_MEMORY       :: Error.OUT_OF_MEMORY;
API_UNAVAILABLE     :: Error.API_UNAVAILABLE;
VERSION_UNAVAILABLE :: Error.VERSION_UNAVAILABLE;
PLATFORM_ERROR      :: Error.PLATFORM_ERROR;
FORMAT_UNAVAILABLE  :: Error.FORMAT_UNAVAILABLE;
NO_WINDOW_CONTEXT   :: Error.NO_WINDOW_CONTEXT;

Window_Attribute :: enum {
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

FOCUSED                  :: Window_Attribute.FOCUSED;
ICONIFIED                :: Window_Attribute.ICONIFIED;
RESIZABLE                :: Window_Attribute.RESIZABLE;
VISIBLE                  :: Window_Attribute.VISIBLE;
DECORATED                :: Window_Attribute.DECORATED;
AUTO_ICONIFY             :: Window_Attribute.AUTO_ICONIFY;
FLOATING                 :: Window_Attribute.FLOATING;
MAXIMIZED                :: Window_Attribute.MAXIMIZED;
CENTER_CURSOR            :: Window_Attribute.CENTER_CURSOR;
TRANSPARENT_FRAMEBUFFER  :: Window_Attribute.TRANSPARENT_FRAMEBUFFER;
HOVERED                  :: Window_Attribute.HOVERED;
FOCUS_ON_SHOW            :: Window_Attribute.FOCUS_ON_SHOW;
RED_BITS                 :: Window_Attribute.RED_BITS;
GREEN_BITS               :: Window_Attribute.GREEN_BITS;
BLUE_BITS                :: Window_Attribute.BLUE_BITS;
ALPHA_BITS               :: Window_Attribute.ALPHA_BITS;
DEPTH_BITS               :: Window_Attribute.DEPTH_BITS;
STENCIL_BITS             :: Window_Attribute.STENCIL_BITS;
ACCUM_RED_BITS           :: Window_Attribute.ACCUM_RED_BITS;
ACCUM_GREEN_BITS         :: Window_Attribute.ACCUM_GREEN_BITS;
ACCUM_BLUE_BITS          :: Window_Attribute.ACCUM_BLUE_BITS;
ACCUM_ALPHA_BITS         :: Window_Attribute.ACCUM_ALPHA_BITS;
AUX_BUFFERS              :: Window_Attribute.AUX_BUFFERS;
STEREO                   :: Window_Attribute.STEREO;
SAMPLES                  :: Window_Attribute.SAMPLES;
SRGB_CAPABLE             :: Window_Attribute.SRGB_CAPABLE;
REFRESH_RATE             :: Window_Attribute.REFRESH_RATE;
DOUBLEBUFFER             :: Window_Attribute.DOUBLEBUFFER;
CLIENT_API               :: Window_Attribute.CLIENT_API;
CONTEXT_VERSION_MAJOR    :: Window_Attribute.CONTEXT_VERSION_MAJOR;
CONTEXT_VERSION_MINOR    :: Window_Attribute.CONTEXT_VERSION_MINOR;
CONTEXT_REVISION         :: Window_Attribute.CONTEXT_REVISION;
CONTEXT_ROBUSTNESS       :: Window_Attribute.CONTEXT_ROBUSTNESS;
OPENGL_FORWARD_COMPAT    :: Window_Attribute.OPENGL_FORWARD_COMPAT;
OPENGL_DEBUG_CONTEXT     :: Window_Attribute.OPENGL_DEBUG_CONTEXT;
OPENGL_PROFILE           :: Window_Attribute.OPENGL_PROFILE;
CONTEXT_RELEASE_BEHAVIOR :: Window_Attribute.CONTEXT_RELEASE_BEHAVIOR;
CONTEXT_NO_ERROR         :: Window_Attribute.CONTEXT_NO_ERROR;
CONTEXT_CREATION_API     :: Window_Attribute.CONTEXT_CREATION_API;
SCALE_TO_MONITOR         :: Window_Attribute.SCALE_TO_MONITOR;
COCOA_RETINA_FRAMEBUFFER :: Window_Attribute.COCOA_RETINA_FRAMEBUFFER;
COCOA_FRAME_NAME         :: Window_Attribute.COCOA_FRAME_NAME;
COCOA_GRAPHICS_SWITCHING :: Window_Attribute.COCOA_GRAPHICS_SWITCHING;
X11_CLASS_NAME           :: Window_Attribute.X11_CLASS_NAME;
X11_INSTANCE_NAME        :: Window_Attribute.X11_INSTANCE_NAME;

API :: enum {
	/* APIs */
	NO_API = bindings.NO_API,
	OPENGL_API = bindings.OPENGL_API,
	OPENGL_ES_API = bindings.OPENGL_ES_API,
}

NO_API        :: API.NO_API;
OPENGL_API    :: API.OPENGL_API;
OPENGL_ES_API :: API.OPENGL_ES_API;

Robustness :: enum {
	/* Robustness? */
	NO_ROBUSTNESS = bindings.NO_ROBUSTNESS,
	NO_RESET_NOTIFICATION = bindings.NO_RESET_NOTIFICATION,
	LOSE_CONTEXT_ON_RESET = bindings.LOSE_CONTEXT_ON_RESET,
}

NO_ROBUSTNESS         :: Robustness.NO_ROBUSTNESS;
NO_RESET_NOTIFICATION :: Robustness.NO_RESET_NOTIFICATION;
LOSE_CONTEXT_ON_RESET :: Robustness.LOSE_CONTEXT_ON_RESET;

OpenGL_Profile :: enum {
	/* OpenGL Profiles */
	OPENGL_ANY_PROFILE = bindings.OPENGL_ANY_PROFILE,
	OPENGL_CORE_PROFILE = bindings.OPENGL_CORE_PROFILE,
	OPENGL_COMPAT_PROFILE = bindings.OPENGL_COMPAT_PROFILE,
}

OPENGL_ANY_PROFILE    :: OpenGL_Profile.OPENGL_ANY_PROFILE;
OPENGL_CORE_PROFILE   :: OpenGL_Profile.OPENGL_CORE_PROFILE;
OPENGL_COMPAT_PROFILE :: OpenGL_Profile.OPENGL_COMPAT_PROFILE;

Input_Mode :: enum {
	/* Cursor draw state and whether keys are sticky */
	CURSOR = bindings.CURSOR,
	STICKY_KEYS = bindings.STICKY_KEYS,
	STICKY_MOUSE_BUTTONS = bindings.STICKY_MOUSE_BUTTONS,
	LOCK_KEY_MODS = bindings.LOCK_KEY_MODS,
}

CURSOR               :: Input_Mode.CURSOR;
STICKY_KEYS          :: Input_Mode.STICKY_KEYS;
STICKY_MOUSE_BUTTONS :: Input_Mode.STICKY_MOUSE_BUTTONS;
LOCK_KEY_MODS        :: Input_Mode.LOCK_KEY_MODS;

Cursor_State :: enum {
	/* Cursor draw state */
	CURSOR_NORMAL = bindings.CURSOR_NORMAL,
	CURSOR_HIDDEN = bindings.CURSOR_HIDDEN,
	CURSOR_DISABLED = bindings.CURSOR_DISABLED,
}

CURSOR_NORMAL   :: Cursor_State.CURSOR_NORMAL;
CURSOR_HIDDEN   :: Cursor_State.CURSOR_HIDDEN;
CURSOR_DISABLED :: Cursor_State.CURSOR_DISABLED;

Behavior :: enum {
	/* Behavior? */
	ANY_RELEASE_BEHAVIOR = bindings.ANY_RELEASE_BEHAVIOR,
	RELEASE_BEHAVIOR_FLUSH = bindings.RELEASE_BEHAVIOR_FLUSH,
	RELEASE_BEHAVIOR_NONE = bindings.RELEASE_BEHAVIOR_NONE,
}

ANY_RELEASE_BEHAVIOR   :: Behavior.ANY_RELEASE_BEHAVIOR;
RELEASE_BEHAVIOR_FLUSH :: Behavior.RELEASE_BEHAVIOR_FLUSH;
RELEASE_BEHAVIOR_NONE  :: Behavior.RELEASE_BEHAVIOR_NONE;

Context_API :: enum {
	/* Context API ? */
	NATIVE_CONTEXT_API = bindings.NATIVE_CONTEXT_API,
	EGL_CONTEXT_API = bindings.EGL_CONTEXT_API,
	OSMESA_CONTEXT_API = bindings.OSMESA_CONTEXT_API,
}

NATIVE_CONTEXT_API :: Context_API.NATIVE_CONTEXT_API;
EGL_CONTEXT_API    :: Context_API.EGL_CONTEXT_API;
OSMESA_CONTEXT_API :: Context_API.OSMESA_CONTEXT_API;

Cursor_Shape :: enum {
	/* Types of cursors */
	ARROW_CURSOR = bindings.ARROW_CURSOR,
	IBEAM_CURSOR = bindings.IBEAM_CURSOR,
	CROSSHAIR_CURSOR = bindings.CROSSHAIR_CURSOR,
	HAND_CURSOR = bindings.HAND_CURSOR,
	HRESIZE_CURSOR = bindings.HRESIZE_CURSOR,
	VRESIZE_CURSOR = bindings.VRESIZE_CURSOR,
	RESIZE_NWSE_CURSOR = bindings.RESIZE_NWSE_CURSOR,
	RESIZE_NESW_CURSOR = bindings.RESIZE_NESW_CURSOR,
}

ARROW_CURSOR       :: Cursor_Shape.ARROW_CURSOR;
IBEAM_CURSOR       :: Cursor_Shape.IBEAM_CURSOR;
CROSSHAIR_CURSOR   :: Cursor_Shape.CROSSHAIR_CURSOR;
HAND_CURSOR        :: Cursor_Shape.HAND_CURSOR;
HRESIZE_CURSOR     :: Cursor_Shape.HRESIZE_CURSOR;
VRESIZE_CURSOR     :: Cursor_Shape.VRESIZE_CURSOR;
RESIZE_NWSE_CURSOR :: Cursor_Shape.RESIZE_NWSE_CURSOR;
RESIZE_NESW_CURSOR :: Cursor_Shape.RESIZE_NESW_CURSOR;

Joystick_State :: enum {
	/* Joystick? */
	CONNECTED = bindings.CONNECTED,
	DISCONNECTED = bindings.DISCONNECTED,
}

CONNECTED    :: Joystick_State.CONNECTED;
DISCONNECTED :: Joystick_State.DISCONNECTED;

Init_Hint :: enum {
	/*  macOS specific init hint. */
	JOYSTICK_HAT_BUTTONS = bindings.JOYSTICK_HAT_BUTTONS,
	COCOA_CHDIR_RESOURCES = bindings.COCOA_CHDIR_RESOURCES,
	COCOA_MENUBAR = bindings.COCOA_MENUBAR,
}
JOYSTICK_HAT_BUTTONS  :: Init_Hint.JOYSTICK_HAT_BUTTONS;
COCOA_CHDIR_RESOURCES :: Init_Hint.COCOA_CHDIR_RESOURCES;
COCOA_MENUBAR         :: Init_Hint.COCOA_MENUBAR;

Misc :: enum {
	/*  */
	DONT_CARE = bindings.DONT_CARE,
}

DONT_CARE :: Misc.DONT_CARE;
