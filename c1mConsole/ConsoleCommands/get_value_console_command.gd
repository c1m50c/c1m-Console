extends ConsoleCommand

# Variables
var property_names: Dictionary = {  }




# Extended Functions
func _init() -> void:
	command_triggers = ["get_value", ARG_TYPES.STRING]
	update_property_names()
	var pn: PoolStringArray = [  ]
	for n in property_names:
		pn.append(n)
	help_info = ["get_value <property_name>", "property_name = %s" % pn]


func _execute_command(args: Array = []) -> String:
	update_property_names()
	for p in property_names:
		if p == args[0]:
			return "Got value: '%s' = %s" % [args[0], property_names[p]]
	return "!Cannot get value of '%s'" % args[0]




# Class Functions
func update_property_names() -> void:
	property_names["fps"] = Performance.get_monitor(Performance.TIME_FPS)
	property_names["console_version"] = Console.CONSOLE_VERSION
