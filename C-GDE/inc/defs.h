#pragma once

#include <stdbool.h>
#include <stdlib.h> //includes stddef.h
#include <string.h>
#include <stdint.h>

#if !defined(GDE_EXPORT)
#if defined(_WIN32)
#define GDE_EXPORT __declspec(dllexport)
#elif defined(__GNUC__)
#define GDE_EXPORT __attribute__((visibility("default")))
#else
#define GDE_EXPORT
#endif

#include "gdextension_interface.h"

typedef struct DokiGDE_Context {
    // Pointers to Godot's API functions
    GDExtensionInterfaceGetProcAddress get_proc_address;
    GDExtensionInterfaceStringNameNewWithUtf8Chars string_name_new_with_utf8_chars;
    GDExtensionClassLibraryPtr class_library;
    GDExtensionInterfaceClassdbRegisterExtensionClass class_db_register_extension_class;

    // buffer to store the StringName for "_ready", "_process", etc... after initialization
    GDExtensionUninitializedStringNamePtr _ready_name;
    GDExtensionUninitializedStringNamePtr _process_name;
    //GDExtensionUninitializedStringNamePtr _..._name;
} DokiGDE_Context;

#endif // ! GDE_EXPORT