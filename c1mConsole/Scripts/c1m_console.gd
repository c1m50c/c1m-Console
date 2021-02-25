extends Control

# Class Variables -> OnReady
onready var Input: LineEdit = $Input
onready var Output: RichTextLabel = $Output

# Class Variables -> Exported
export(Color) var output_line_number_clr: Color = Color(0, 1, 0.5)

# Class Variables -> Data
var output_line_count: int = 0
var console_commands: Array = [  ]




# Extended Fucntions
func _ready() -> void:
	clear_output()
	create_console_commands()




# Class Functions -> Creation
func create_console_commands() -> void:
	var cc_file_names: PoolStringArray = [  ]

	# Get File Names for the Files in the ConsoleCommands Directory
	var dir: Directory = Directory.new()
	if dir.open("res://c1mConsole/ConsoleCommands") == OK:
		#warning-ignore:return_value_discarded
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir(): # Item is File
				cc_file_names.append(file_name)
			file_name = dir.get_next()

	# Create 'ConsoleCommand' Refrences from File Names in 'cc_file_names'
	for ccfn in cc_file_names:
		var cc_script: GDScript = load("res://c1mConsole/ConsoleCommands/%s" % ccfn)
		var cc_obj: ConsoleCommand = ConsoleCommand.new()
		cc_obj.set_script(cc_script)
		console_commands.append(cc_obj)


# Class Functions -> Signal
func _on_Input_text_changed(_new_text: String) -> void:
	pass # TODO -> Syntax Highlighting


func _on_Input_text_entered(new_text: String) -> void:
	process_command(new_text)




# Class Functions -> IO
func clear_output() -> void:
	Output.bbcode_text = "[ Beginning of Console Output ]"
	output_line_count = 0


func write_to_output(text: String) -> void:
	output_line_count += 1
	Output.bbcode_text = Output.bbcode_text + "\n%s %s" % [ 
			"[color=#%s]" % [output_line_number_clr.to_html()] + str(output_line_count) + ".[/color]", 
			text ]




# Class Functions -> Processing
func process_command(command: String) -> void:
	for r in console_commands:
		if command in r.command_triggers[0]:
			print("yes")
		else:
			print("no")
	pass # TODO -> Command Processing
