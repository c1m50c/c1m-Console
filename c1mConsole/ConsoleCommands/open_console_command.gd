extends ConsoleCommand

# Variables
var open_names: Dictionary = {
	# <open_name>: <path>,
	"github": "https://github.com/c1m50c/c1m-Console",
}




# Extended Functions
func _init() -> void:
	command_triggers = ["open", ARG_TYPES.STRING]
	help_info = ["open <path || open_name>", "<open_name> = %s" % [open_names.keys()]]


func _execute_command(args: Array = []) -> String:
	var open_path: String = args[0]
	for key in open_names:
		if args[0] == key:
			open_path = open_names[key]

	if OS.shell_open(open_path) == OK:
		return "Opened '%s'." % open_path
	else:
		return "!Could not open '%s'." % open_path
