extends Node2D

#var levelin = preload("res://scripts/LevelInputs.gd")

onready var cam = $Level/GameWorld/level_1/Camera2D
onready var player = $Level/GameWorld/level_1/Player
onready var level = $Level/GameWorld/level_1
onready var gameWorld = $Level/GameWorld

onready var errorHandler = $GameUI/Error
onready var editor = $GameUI/Editor
onready var varList = $GameUI/Variables
onready var openingLine = $GameUI/openingLine
onready var winStatus = $GameUI/winStatus
onready var pauseMenu = $GameUI/pause_menu

var score = 5000
var loc
var disks = 0

var curLevel = 1

signal toggleData

enum {NORM, VOID}
var curTile = NORM

func calculate_final_score():
	loc = editor.text.get_line_count()
	score -= (loc * 100)

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

func _process(_delta):
	pass

func _on_ToggleData_pressed():
	emit_signal("toggleData")

func reset_game():
	get_tree().call_group("tiles", "show")


func _on_pauseButton_pressed():
	pauseMenu.popup_centered()

func change_level():
	reset_game()
	editor.reset()
	editor.text.text = ""
	
	var new_level = load("res://levels/level_" + str(curLevel + 1) + ".tscn")
	var new_level_instance = new_level.instance()
	level.queue_free()
	level = new_level_instance
	
	editor.vars[0]["value"] = level.playerStart.x
	editor.vars[1]["value"] = level.playerStart.y
	
	gameWorld.add_child(new_level_instance)
