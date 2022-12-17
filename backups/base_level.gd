extends Node2D

onready var cam = $Control/Level/Viewport/tiles/Camera2D
onready var player = $Control/Level/Viewport/tiles/Player
onready var tiles = $Control/Level/Viewport/tiles

onready var editor = $Control/UI/Viewport/Editor
onready var varList = $Control/UI/Viewport/Variables

enum {NORM, VOID, INP, DISK, LOCK, OPEN, PORT, EXIT}
var curTile = NORM

export var mapSize = [15, 10]

export var inputs = [{"coords": Vector2(0,1), "key": "key", "keyType": "string"},
					{"coords": Vector2(0,2), "key": 100, "keyType": "integer"}]

onready var locks = [{"coords": Vector2(1,1), "key": "key"},
					{"coords": Vector2(1,2), "key": 100}]

onready var ports = [{"from": Vector2(0,1), "to": Vector2(0,1)}]

onready var playerStart = [0,0]

onready var intro = " "
onready var outro = " "

onready var curLevel = 0
onready var nextLevel = get_tree().change_scene("res://levels/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")

func set_camera():
	var map_limits = tiles.get_used_rect()
	var map_cellsize = tiles.cell_size
	cam.limit_left = map_limits.position.x * map_cellsize.x
	cam.limit_right = map_limits.end.x * map_cellsize.x
	cam.limit_top = map_limits.position.y * map_cellsize.y
	cam.limit_bottom = map_limits.end.y * map_cellsize.y
	
	cam.zoom.x = 0.5
	cam.zoom.y = 0.5

func _ready():
	set_camera()
	
	editor.vars[0]["value"] = playerStart[0]
	editor.vars[1]["value"] = playerStart[1]

func _process(delta):
	editor.vars[0]["value"] = clamp(editor.vars[0]["value"], 0, mapSize[0]-1)
	editor.vars[1]["value"] = clamp(editor.vars[1]["value"], 0, mapSize[1]-1)
	
	player.position.x = editor.vars[0]["value"] * 72
	player.position.y = editor.vars[1]["value"] * 72

func _on_codeEditor_pressed():
	if !editor.visible:
		editor.show()
	elif editor.visible:
		editor.hide()

func _on_varList_pressed():
	if !varList.visible:
		varList.show()
	elif varList.visible:
		varList.hide()
		
func tile_effect():
	curTile = tiles.get_cell(editor.vars[0]["value"], editor.vars[1]["value"])
	
	if(curTile == NORM):
		pass
	elif(curTile == VOID):
		player.position.x = editor.prevLocation.x * 72
		player.position.y = editor.prevLocation.y * 72
		#Should throw error THEN reset
		editor.reset()
	elif(curTile == INP):
		pass
	elif(curTile == DISK):
		print("SCORED")
		tiles.set_cell(editor.vars[0]["value"], editor.vars[1]["value"], NORM)
	elif(curTile == LOCK):
		player.position.x = editor.prevLocation.x * 72
		player.position.y = editor.prevLocation.y * 72
		#Should throw error THEN reset
		editor.reset()
	elif(curTile == PORT):
		for i in ports:
			if((ports[i]["from"].x == editor.playerLocation.x) and (ports[i]["from"].y == editor.playerLocation.y)):
				editor.vars[0]["value"] = ports[i]["to"].x
				editor.vars[1]["value"] = ports[i]["to"].y
	elif(curTile == EXIT):
		print("LEVEL END")
		#Show win card, go to next level
