#include "init.h"

void initialize_gdexample_module(void *p_userdata, GDExtensionInitializationLevel p_level)
{
}

void deinitialize_gdexample_module(void *p_userdata, GDExtensionInitializationLevel p_level)
{
}

GDExtensionBool GDE_EXPORT gdexample_library_init(GDExtensionInterfaceGetProcAddress p_get_proc_address, GDExtensionClassLibraryPtr p_library, GDExtensionInitialization *r_initialization)
{
    r_initialization->initialize = initialize_gdexample_module;
    r_initialization->deinitialize = deinitialize_gdexample_module;
    r_initialization->userdata = NULL;
    r_initialization->minimum_initialization_level = GDEXTENSION_INITIALIZATION_SCENE;

    return true;
}