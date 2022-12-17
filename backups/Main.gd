extends Node2D


onready var player = $Player
onready var code = $Editor
onready var level = $Camera2D
var playerPos = Vector2(0,0)
var dragging = false



# Called when the node enters the scene tree for the first time.
func _ready():
	code.popup()
	code.text.rect_size.y = 96
	
	set_process_input(true)

func _process(delta):
	 pass

