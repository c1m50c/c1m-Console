extends ConsoleCommand

# Extended Functions
func _init() -> void:
	command_triggers = ["open", ARG_TYPES.STRING]
	help_info = ["open <path / open_names>", "open_names = 'github'"]


func _execute_command(args: Array = []) -> String:
	var open_path: String = args[0]
	match args[0]: # 'open_names' AKA path to open based on str given
		"github":
			open_path = "https://github.com/c1m50c/c1m-Console"

	if OS.shell_open(open_path) == OK:
		return "Opened '%s'." % open_path
	else:
		return "!Could not open '%s'." % open_path
