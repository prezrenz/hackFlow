extends Node2D

#var levelin = preload("res://scripts/LevelInputs.gd")

onready var cam = $Control/Level/GameWorld/level/Camera2D
onready var player = $Control/Level/GameWorld/level/Player
onready var level = $Control/Level/GameWorld/level

onready var editor = $Control/GameUI/Editor
onready var varList = $Control/GameUI/Variables

onready var score = 5000

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

func _process(delta):
	editor.vars[0]["value"] = clamp(editor.vars[0]["value"], 0, level.mapSize.x-1)
	editor.vars[1]["value"] = clamp(editor.vars[1]["value"], 0, level.mapSize.y-1)
	
	player.position.x = editor.vars[0]["value"] * 72
	player.position.y = editor.vars[1]["value"] * 72
	
	curTile = level.get_cell(editor.vars[0]["value"], editor.vars[1]["value"])
	
	if(curTile == VOID):
		editor.return_player()

#func tile_effect():
#	curTile = level.get_cell(editor.vars[0]["value"], editor.vars[1]["value"])
#
#	if(curTile == NORM):
#		pass
#	elif(curTile == VOID):
#		player.position.x = editor.prevLocation.x * 72
#		player.position.y = editor.prevLocation.y * 72
#		#Should throw error THEN reset
#		editor.reset()
#	elif(curTile == INP):
#		pass
#	elif(curTile == DISK):
#		print("SCORED")
#		level.set_cell(editor.vars[0]["value"], editor.vars[1]["value"], NORM)
#	elif(curTile == LOCK):
#		player.position.x = editor.prevLocation.x * 72
#		player.position.y = editor.prevLocation.y * 72
#		#Should throw error THEN reset
#		editor.reset()
#	elif(curTile == PORT):
#		for i in ports:
#			if((ports[i]["from"].x == editor.playerLocation.x) and (ports[i]["from"].y == editor.playerLocation.y)):
#				editor.vars[0]["value"] = ports[i]["to"].x
#				editor.vars[1]["value"] = ports[i]["to"].y
#	elif(curTile == EXIT):
#		print("LEVEL END")
#		#Show win card, go to next level
