extends ConsoleCommand

# Extended Functions
func _init() -> void:
	command_triggers = ["help"]


func _execute_command(_args: Array = []) -> String:
	print(get_cc_scripts())
	return ""




# Class Functions
func get_cc_scripts() -> Array:
	var array: Array = [  ]

	var dir: Directory = Directory.new()
	var file_names: PoolStringArray = [  ]
	if dir.open("res://c1mConsole/ConsoleCommands") == OK:
		#warning-ignore:return_value_discarded
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir(): # Item is File
				file_names.append(file_name)
			file_name = dir.get_next()

	array.append(file_names)
	return array