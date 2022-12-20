extends AcceptDialog

onready var root = get_tree().get_current_scene()
onready var cmdLabel = $VBoxContainer/CmdLabel
onready var errorLabel = $VBoxContainer/ErrorLabel

func _ready():
	self.get_close_button().visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func error(errorText: String, errorCmd: String, errorLine: int):
	var error = "At line %d: %s\n" % [errorLine, errorCmd.to_upper()]
	error = error + errorText + "\n"
	
	self.set_text(error)
	
	popup_centered()

func _on_Error_confirmed():
	root.reset_game()
	root.editor.reset()
