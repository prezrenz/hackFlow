extends TileMap

export var mapSize = Vector2(15, 10)

export var playerStart = Vector2(0,0)

export(String, MULTILINE) var intro
export(String, MULTILINE) var outro


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
