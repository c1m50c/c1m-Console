extends Control

# Class Variables -> OnReady
onready var ConsoleInput: LineEdit = $Input
onready var ConsoleOutput: RichTextLabel = $Output

# Class Variables -> Exported
export(bool) var hide_on_ready: bool = true
export(Color) var output_line_number_clr: Color = Color(0, 1, 0.5)

# Class Variables -> Data
var output_line_count: int = 0
var console_commands: Array = [  ]




# Extended Fucntions
func _ready() -> void:
	visible = !hide_on_ready
	clear_output()
	create_console_commands()


func _input(event: InputEvent) -> void:
	var just_pressed: bool = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_QUOTELEFT) and just_pressed:
		visible = !visible




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


func _on_ClearOutput_pressed() -> void:
	clear_output()




# Class Functions -> IO
func clear_output() -> void:
	ConsoleOutput.bbcode_text = "[ Beginning of Console Output ]"
	output_line_count = 0


func write_to_output(text: String) -> void:
	if text.empty():
		return
	elif text.begins_with("!"):
		var text_split: PoolStringArray = text.split("!", false, 1)
		write_error_to_output(text_split[0])
		return

	output_line_count += 1
	ConsoleOutput.bbcode_text = ConsoleOutput.bbcode_text + "\n%s %s" % [ 
			"[color=#%s]" % [output_line_number_clr.to_html()] + str(output_line_count) + ".[/color]", 
			text ]


func write_error_to_output(description: String) -> void:
	if description.empty():
		return

	output_line_count += 1
	ConsoleOutput.bbcode_text = ConsoleOutput.bbcode_text + "\n%s %s" % [ 
			"[color=#%s]" % [output_line_number_clr.to_html()] + str(output_line_count) + ".[/color]", 
			"[color=#ff0000][b]ERROR: [/b][/color]" + description]




# Class Functions -> Command Processing
func check_trigger_type(trigger: String, type: int) -> bool:
	match type:
		ConsoleCommand.ARG_TYPES.INT:
			return trigger.is_valid_integer()
		ConsoleCommand.ARG_TYPES.FLOAT:
			return trigger.is_valid_float()
		ConsoleCommand.ARG_TYPES.BOOL:
			return trigger == "true" or trigger == "false"
		ConsoleCommand.ARG_TYPES.STRING:
			return true
		ConsoleCommand.ARG_TYPES.VEC2:
			var split_str: PoolStringArray = trigger.split(",", false, 2)
			if split_str.size() == 2:
				if split_str[0].is_valid_float():
					if split_str[1].is_valid_float():
						return true
		ConsoleCommand.ARG_TYPES.VEC3:
			var split_str: PoolStringArray = trigger.split(",", false, 3)
			if split_str.size() == 3:
				if split_str[0].is_valid_float():
					if split_str[1].is_valid_float():
						if split_str[2].is_valid_float():
							return true
	return false


func process_command(command: String) -> void:
	# TODO -> Full Command Processing
	write_to_output(">>> %s" % command)
	var split_str: Array = command.split(" ", true)
	for i in range(split_str.count("")):
		split_str.erase("")

	var command_word: String = split_str.pop_front()
	for cmd in console_commands:
		if cmd.command_triggers[0] == command_word:
			if cmd.command_triggers.size() == 1:
				write_to_output(cmd.call("_execute_command"))
				return
			if split_str.size() != cmd.command_triggers.size() - 1:
				write_error_to_output("Failure executing Command '%s', expected '%s' arguments." % [
						command_word, cmd.command_triggers.size() - 1])
				return
			for i in range(split_str.size()):
				if not check_trigger_type(split_str[i], cmd.command_triggers[i -1]):
					write_error_to_output("Failure executing Command '%s', argument '%s:%s' is of wrong tpye." % [
							command_word, i, split_str[i]])
					return
			write_to_output(cmd.call("_execute_command", split_str))
			return
	write_error_to_output("Entered Command is non-existent.")
