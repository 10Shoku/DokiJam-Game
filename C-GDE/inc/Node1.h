#ifndef _NODE1_H_
#define _NODE1_H_
#include "defs.h"

GDExtensionObjectPtr Node1_create(void* p_class_userdata, GDExtensionBool p_notify_postinitialize);

void Node1_free(void* p_class_userdata, GDExtensionClassInstancePtr p_instance);

GDExtensionClassCallVirtual Node1_get_virtual_func(void* p_class_userdata, GDExtensionConstStringNamePtr p_name, uint32_t p_hash);

//ret_type Node_... (args);

#endif //_NODE1_H_