class_name ConsoleCommand, "res://c1mConsole/Assets/Textures/console_command_class_icon.png"
extends Reference

# Class Enums
enum ARG_TYPES { INT, FLOAT, BOOL, STRING, VEC2, VEC3 }

# Class Variables
var help_info: Array = [
	# Holds strings that get printed to the output when the 'help' command is executed
	# See various built-in command's '_init' method for examples, Proper format goes...

	# "command_trigger + <ARG_TYPES/Argument Names>",
	# "<Argument_Name> = [Argument Names]",
]
var command_triggers: Array = [
	"command_trigger", # Command Name
	ARG_TYPES.STRING, # Argument 1 ( Unlimited Args )
	ARG_TYPES.INT, # Argument 2
]




# Extended Functions
func _init() -> void:
	pass




# Class Functions
#warning-ignore:unused_argument
func _execute_command(args: Array = []) -> String:
	# Returned String will be printed out into the ConsoleOutput, prefix String with a '!' to call an error
	return ""
