#include "gobjectWrapper.h"

G_DEFINE_TYPE(GObjectWrapper, gobject_wrapper, G_TYPE_OBJECT)

static void gobject_wrapper_class_init(GObjectWrapperClass *klass)
{
}

static void gobject_wrapper_init(GObjectWrapper *self)
{
}

void *gobject_wrapper_get_data(GObjectWrapper *self)
{
    return self->data;
}

GObjectWrapper *gobject_wrapper_new(void *data)
{
    GObjectWrapper *self = g_object_new(GOBJECT_TYPE_WRAPPER, NULL);
    self->data = data;
    return self;
}