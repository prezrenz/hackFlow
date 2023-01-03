extends Node2D

#var levelin = preload("res://scripts/LevelInputs.gd")

onready var cam = $Level/GameWorld/level/Camera2D
onready var player = $Level/GameWorld/level/Player
onready var level = $Level/GameWorld/level

onready var errorHandler = $GameUI/Error
onready var editor = $GameUI/Editor
onready var varList = $GameUI/Variables
onready var openingLine = $GameUI/openingLine
onready var winStatus = $GameUI/winStatus

onready var score = 5000

signal toggleData

enum {NORM, VOID}
var curTile = NORM

func set_camera():
	var map_limits = level.get_used_rect()
	var map_cellsize = level.cell_size
	cam.limit_left = map_limits.position.x * map_cellsize.x - 100
	cam.limit_right = map_limits.end.x * map_cellsize.x + 100
	cam.limit_top = map_limits.position.y * map_cellsize.y - 100
	cam.limit_bottom = map_limits.end.y * map_cellsize.y + 100
	
	cam.zoom.x = 0.5
	cam.zoom.y = 0.5

func _ready():
	set_camera()

	editor.vars[0]["value"] = level.playerStart.x
	editor.vars[1]["value"] = level.playerStart.y
	
	openingLine.popup_centered()

func _process(delta):
	editor.vars[0]["value"] = clamp(editor.vars[0]["value"], 0, level.mapSize.x-1)
	editor.vars[1]["value"] = clamp(editor.vars[1]["value"], 0, level.mapSize.y-1)
	
	player.position.x = editor.vars[0]["value"] * 72
	player.position.y = editor.vars[1]["value"] * 72
	
	curTile = level.get_cell(editor.vars[0]["value"], editor.vars[1]["value"])
	
	if(curTile == VOID):
		editor.return_player()

func _on_ToggleData_pressed():
	emit_signal("toggleData")

func reset_game():
	get_tree().call_group("tiles", "show")
