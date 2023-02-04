#pragma once

#include <glib-object.h>

G_BEGIN_DECLS

#define GOBJECT_TYPE_WRAPPER gobject_wrapper_get_type()
G_DECLARE_FINAL_TYPE (GObjectWrapper, gobject_wrapper, GOBJECT, WRAPPER, GObject)

struct _GObjectWrapper {
    GObject parent_instance;
    char* data;
};

GObjectWrapper *gobject_wrapper_new(void *data);

G_END_DECLS