extends ConsoleCommand

# Variables
var property_info: Dictionary = { # Add properties in 'update_property_info' method.
	# <property_name>: <property_value> / <property_get_method>,
}




# Extended Functions
func _init() -> void:
	update_property_info()
	command_triggers = ["print", ARG_TYPES.STRING]
	help_info = ["print <property_name>", "<property_name> = %s" % get_property_names()]


func _execute_command(args: Array = []) -> String:
	update_property_info()
	for key in property_info:
		if key == args[0]:
			return "print: '%s' = %s." % [ args[0], property_info[key] ]
	return "!Cannot print '%s'." % args[0]




# Functions
func get_property_names() -> PoolStringArray:
	var array: PoolStringArray = [  ]
	for key in property_info:
		array.append(key)
	return array


func update_property_info() -> void:
	property_info["fps"] = Performance.get_monitor(Performance.TIME_FPS)
	property_info["console_version"] = Console.CONSOLE_VERSION