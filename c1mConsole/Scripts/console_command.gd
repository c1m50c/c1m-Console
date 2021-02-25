class_name ConsoleCommand, "res://c1mConsole/Assets/Textures/console_command_class_icon.png"
extends Reference

# Class Enums
enum ARG_TYPES { INT, FLOAT, BOOL, STRING, VEC2, VEC3 }

# Class Variables
var command_triggers: Array = [
	"command_trigger", # Command Name
	ARG_TYPES.STRING, # Argument 1 ( Unlimited )
	ARG_TYPES.INT, # Argument 2
]




# Extended Functions
func _init() -> void:
	pass




# Class Functions
#warning-ignore:unused_argument
func _execute_command(args: Array = []) -> String:
	return ""
