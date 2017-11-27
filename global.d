module global;

import Add_on_API;

// API requirement to function

enum EXT_IUTIL;
enum EXT_ICOMMAND;
enum EXT_ICINIFILE;

// Future API support

//enum EXT_HKEXTERNAL;           // TBD


addon_info EXTPluginInfo = { "UnitTestHookD", "1.0.0.0",
"DZS|All-In-One, founder of DZS",
"Used for verifying each API are working right in D language under C99 standard.",
"UnitTestHook",
sectors: {"unit_test",
    "test_unit",
    "unit test",
    "[unit]test",
    "test[unit]"} };
