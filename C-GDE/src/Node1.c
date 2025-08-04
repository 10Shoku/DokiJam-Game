#include "Node1.h"

// lifecycle functions

GDExtensionObjectPtr Node1_create(void* p_class_userdata, GDExtensionBool p_notify_postinitialize) {
    DokiGDE_Context* ctx = (DokiGDE_Context*)p_class_userdata; //get context from userdata
    return;
}

void Node1_free(void* p_class_userdata, GDExtensionClassInstancePtr p_instance) {
    DokiGDE_Context* ctx = (DokiGDE_Context*)p_class_userdata; //get context from userdata
    return;
}

// virtual functions

void Node1_ready(GDExtensionClassInstancePtr p_instance, const GDExtensionConstTypePtr* p_args, GDExtensionTypePtr r_ret) {
    return;
}

void Node1_process(GDExtensionClassInstancePtr p_instance, const GDExtensionConstTypePtr* p_args, GDExtensionTypePtr r_ret) {
    return;
}

GDExtensionClassCallVirtual Node1_get_virtual_func(
    void* p_class_userdata,
    GDExtensionConstStringNamePtr p_name,
    uint32_t p_hash) {
    DokiGDE_Context* ctx = (DokiGDE_Context*)p_class_userdata; //get context from userdata

    // Compare p_name with the StringNames you stored
    if (strcmp(p_name, ctx->_ready_name) == 0) {
        return Node1_ready;
    } else if (strcmp(p_name, ctx->_process_name) == 0) {
        // If it's "_process", return a function pointer to your implementation
        return Node1_process;
    } /* else if (strcmp(p_name, ctx->_..._name) == 0) {
        return Node1_...;
    } */

    // If you don't have an implementation for the requested name, return NULL
    return NULL;
}