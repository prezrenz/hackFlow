extends AcceptDialog

onready var root = get_tree().get_current_scene()

var quitGame
var won

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_close_button().visible = false
	self.get_label().set_align(1)
	self.get_ok().set_text_align(1)
	
	quitGame = self.add_button("Quit Game", true, "quit_game")
	quitGame.set_text_align(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_status(var is_won):
	if(is_won):
		self.window_title = "You Won!"
		self.get_label().text = root.level.outro
		self.get_ok().text = "Next Level"
		won = true
	else:
		self.window_title = "You Failed!"
		self.get_label().text = "Don't give up, find the pattern and get to the Exit Signal!"
		self.get_ok().text = "Reset"
		won = false


func _on_winStatus_confirmed():
	if(won == true):
		pass # Next Level
	else:
		root.editor.reset()


func _on_winStatus_custom_action(action):
	if(action == "quit_game"):
		get_tree().quit() # Should quit to main menu
