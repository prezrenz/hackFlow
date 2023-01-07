extends TileMap

export var mapSize = Vector2(15, 10)

export var playerStart = Vector2(0,0)

export(String, MULTILINE) var intro
export(String, MULTILINE) var outro

export var curLevel = 0
onready var nextLevel = get_tree().change_scene("res://levels/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
