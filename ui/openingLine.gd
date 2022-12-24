extends AcceptDialog

onready var root = get_tree().get_current_scene()
onready var level = root.get_node("Level/GameWorld/level")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_close_button().visible = false
	self.get_label().set_align(1)
	
	self.dialog_text = level.intro
	self.window_title = "Level " + str(level.curLevel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
