extends ConsoleCommand

# Constants
const UPDATE_COMMANDS_ON_ALL_EXECUTIONS: bool = false # Forces 'commands' to update on all executions

# Variables -> Data
var commands: Array = [  ]




# Extended Functions
func _init() -> void:
	command_triggers = ["help"]
	help_info = ["help"]


func _execute_command(_args: Array = []) -> String:
	var rstring: String = "Help Info: [\n"
	if commands.empty() or UPDATE_COMMANDS_ON_ALL_EXECUTIONS:
		commands.clear()
		commands = get_console_commands()

	for cmd in commands:
		rstring = rstring + "[color=#fcc05d][b]%s:[/b][/color] %s\n" % [
				cmd.command_triggers[0], cmd.help_info]
	rstring = rstring + "]"

	return rstring




# Class Functions
func get_console_commands() -> Array:
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
	
	for name in file_names:
		var cc_script: GDScript = load("res://c1mConsole/ConsoleCommands/%s" % name)
		var cc: ConsoleCommand = ConsoleCommand.new()
		cc.set_script(cc_script)
		array.append(cc)
	return array