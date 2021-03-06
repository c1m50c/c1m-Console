extends ConsoleCommand

# Variables -> Data
var property_info: Dictionary = {
	# <property_name>: [ <property_holder> <set_function_of_property>, <property_type> ]
	"Input.mouse_mode": [ Input, "set_mouse_mode", ARG_TYPES.INT ]
}




# Extended Functions
func _init() -> void:
	# Due to their being few ARG_TYPES, 2nd Arguement ( Value ) will be string, will convert in dif function
	command_triggers = ["set_value", ARG_TYPES.STRING, ARG_TYPES.STRING]
	help_info = ["set_value <property_name> <property_value>", "<property_name:property_type> = %s" % get_properties()]


func _execute_command(args: Array = []) -> String:
	for key in property_info:
		if key == args[0]:
			if Console.check_trigger_type(args[1], property_info[key][2]):
				match property_info[key][2]:
					ARG_TYPES.INT:
						property_info[key][0].call(property_info[key][1], int(args[1]))
					ARG_TYPES.FLOAT:
						property_info[key][0].call(property_info[key][1], float(args[1]))
					ARG_TYPES.BOOL:
						property_info[key][0].call(property_info[key][1], bool(args[1]))
					ARG_TYPES.STRING:
						property_info[key][0].call(property_info[key][1], args[1])
					ARG_TYPES.VEC2:
						property_info[key][0].call(property_info[key][1], Console.str_to_vec2(args[1]))
					ARG_TYPES.VEC3:
						property_info[key][0].call(property_info[key][1], Console.str_to_vec3(args[1]))
				return ""
			else:
				return "![b]set_value: [/b]Cannot convert Argument:2 to proper type."
	return "![b]set_value: [/b] Cannot set the value of '%s = %s'." % [args[0], args[1]]




# Script Functions
func get_properties() -> PoolStringArray:
	var array: PoolStringArray = [  ]
	for key in property_info:
		array.append("%s:%s" % [ key, ARG_TYPES.keys()[property_info[key][2]] ])
	return array


func add_property(property_name: String, property_holder: Object, property_set_method: String, property_type: int) -> void:
	property_info[property_name] = [ property_holder, property_set_method, property_type ]