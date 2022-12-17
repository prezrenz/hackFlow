extends Sprite

var tileName = "lock"

onready var keyLabel = $Data

export(String, "string", "integer") var type
export(int) var keyInt
export(String) var keyStr

# Called when the node enters the scene tree for the first time.
func _ready():
	var keyL = Label.new()
	
	if(type == "string"):
		keyL.set_text(keyStr)
	elif(type == "integer"):
		keyL.set_text(str(keyInt))
	else:
		pass
	
	keyL.set_align(1)
	keyLabel.add_child(keyL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

