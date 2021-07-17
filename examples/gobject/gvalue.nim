import gintro/[gobject]

var value: Value
discard init(value, g_string_get_type())

value.string = "sas"
echo value.getString

value.unset()

discard init(value, g_boolean_get_type())
value.boolean = true
echo value.boolean

value.unset()

discard init(value, g_int_get_type())
value.int = 42
echo value.getInt