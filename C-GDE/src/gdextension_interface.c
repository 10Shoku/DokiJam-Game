#include "defs.h"
#include "Node1.h"

// Initialization and de-initialization functions
void DokiGDE_init(void* userdata, GDExtensionInitializationLevel p_level) {
    /** init levels
     * GDEXTENSION_INITIALIZATION_CORE //engine core init
     * GDEXTENSION_INITIALIZATION_SERVERS //render and physc servers init
     * GDEXTENSION_INITIALIZATION_SCENE //scene management classes (like Object, Node, etc.) are available, here nodes are registered
     * GDEXTENSION_INITIALIZATION_EDITOR //editor-specific classes are registered.
     */
    if (p_level == GDEXTENSION_INITIALIZATION_SCENE) {
        DokiGDE_Context* ctx = (DokiGDE_Context*)userdata; //get context from userdata

        // Register classes/nodes here

        // Get the function pointer for class_db_register_extension_class
        ctx->class_db_register_extension_class = (GDExtensionInterfaceClassdbRegisterExtensionClass4)ctx->get_proc_address("classdb_register_extension_class4");

        // Get the virtual function name strings
        ctx->_ready_name = ctx->mem_alloc(sizeof(StringName));
        ctx->string_name_new_with_utf8_chars(ctx->_ready_name, "_ready");
        ctx->_process_name = ctx->mem_alloc(sizeof(StringName));
        ctx->string_name_new_with_utf8_chars(ctx->_process_name, "_process");
        //ctx->_..._name = ctx->mem_alloc(sizeof(StringName));
        //ctx->string_name_new_with_utf8_chars(ctx->_..._name, "_...");
        //...

        // Define your classes' info and register them

        //Node1
        GDExtensionClassCreationInfo4 Node1_info = {0};
        Node1_info.create_instance_func = Node1_create;
        Node1_info.free_instance_func = Node1_free;
        Node1_info.get_virtual_func = Node1_get_virtual_func; // for methods like _ready, _process
        Node1_info.class_userdata = ctx;
        ctx->class_db_register_extension_class(ctx->class_library, "Node1", "Node", &Node1_info);

        //GDExtensionClassCreationInfo4 class_info = {0};
        //class_info.create_instance_func = class_create;
        //class_info.free_instance_func = class_free;
        //class_info.get_virtual_func = class_get_virtual_func; // for methods like _ready, _process
        //class_info.class_userdata = ctx;
        //class_db_register_extension_class(ctx->class_library, "class-name", "inherated-class-name", &class_info);
    }
}

void DokiGDE_deinit(void* userdata, GDExtensionInitializationLevel p_level) {
    if (p_level == GDEXTENSION_INITIALIZATION_SCENE) {
        DokiGDE_Context* ctx = (DokiGDE_Context*)userdata; //get context from userdata
        // Clean up here, no need for deregister of nodes
    }
}

// The entry point for your library
GDExtensionBool GDE_EXPORT DokiGDE_main(
    GDExtensionInterfaceGetProcAddress p_get_proc_address,
    GDExtensionClassLibraryPtr p_library,
    GDExtensionInitialization* r_initialization) {

    DokiGDE_Context* ctx = calloc(1, sizeof(DokiGDE_Context));

    ctx->get_proc_address = p_get_proc_address;
    ctx->class_library = p_library;
    ctx->string_name_new_with_utf8_chars = (GDExtensionInterfaceStringNameNewWithUtf8Chars)ctx->get_proc_address("string_name_new_with_utf8_chars");
    ctx->mem_alloc = (GDExtensionInterfaceMemAlloc)ctx->get_proc_address("mem_alloc");
    ctx->mem_free = (GDExtensionInterfaceMemFree)ctx->get_proc_address("mem_free");

    // Set up the initialization functions and levels
    r_initialization->deinitialize = DokiGDE_deinit;
    r_initialization->initialize = DokiGDE_init;
    r_initialization->userdata = ctx;
    r_initialization->minimum_initialization_level = GDEXTENSION_INITIALIZATION_SCENE;

    return true;
}
