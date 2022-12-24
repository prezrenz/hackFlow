extends AcceptDialog

onready var root = get_tree().get_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_close_button().visible = false
	self.get_label().set_align(1)
	
	self.popup_centered()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_winStatus_confirmed():
	pass # TODO: Next Level
