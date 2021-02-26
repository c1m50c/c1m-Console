extends ConsoleCommand

# Extended Functions
func _init() -> void:
	command_triggers = ["print", ARG_TYPES.STRING]
	help_info = ["print <String>"]


func _execute_command(args: Array = []) -> String:
	print(args[0])
	return args[0]