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
#ifdef BUILD_32
#define STRING_NAME_SIZE 4
#else
#define STRING_NAME_SIZE 8
#endif

// Types.

typedef struct {
    uint8_t data[STRING_NAME_SIZE];
} StringName;

#include "gdextension_interface.h"

typedef struct DokiGDE_Context {
    // Pointers to Godot's API functions
    GDExtensionInterfaceGetProcAddress get_proc_address;
    GDExtensionInterfaceStringNameNewWithUtf8Chars string_name_new_with_utf8_chars;
    GDExtensionClassLibraryPtr class_library;
    GDExtensionInterfaceClassdbRegisterExtensionClass4 class_db_register_extension_class;
    GDExtensionInterfaceMemAlloc mem_alloc;
    GDExtensionInterfaceMemFree mem_free;

    // buffer to store the StringName for "_ready", "_process", etc... after initialization
    GDExtensionStringNamePtr _ready_name;
    GDExtensionStringNamePtr _process_name;
    //GDExtensionStringNamePtr _..._name;
} DokiGDE_Context;

#endif // ! GDE_EXPORT
