extends Area2D

onready var spr = $Sprite
onready var dir = $Directions
onready var coll = $CollisionShape2D
onready var root = get_tree().root
onready var editor = root.get_node("Game/GameUI/Editor")

onready var disk = preload("res://tiles/disk.tscn")
onready var exit = preload("res://tiles/exit.tscn")
onready var input = preload("res://tiles/input.tscn")
onready var lock = preload("res://tiles/lock.tscn")
onready var port = preload("res://tiles/port.tscn")

var inputNode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func unlock(var variable): #THERE HAS TO BE A BETTER WAY
	var overlaps = dir.get_overlapping_areas()
	
	if overlaps.empty():
		return
		
	#print(overlaps)
	
	for i in overlaps.size():
		var node = overlaps[i].get_parent()
		
		if node.tileName != "lock":
			continue
		
		if node.type == variable["type"]:
			
			if variable["type"] == "string":
				if variable["value"] == node.keyStr:
					node.hide()
			elif variable["type"] == "integer":
				if variable["value"] == node.keyInt:
					node.hide()
			else:
				pass #error here
				
					


func _on_Player_area_entered(area):
	var node = area.get_owner()
	print(node)
	if(node.visible == false):
		pass
	
	if(node.get_filename() == disk.get_path()):
		root.score += 500
	elif(node.get_filename() == exit.get_path()):
		print("exit")
	elif(node.get_filename() == input.get_path()):
		inputNode = node
	elif(node.get_filename() == lock.get_path()):
		print(node)
		print(node.visible)
		if(node.visible == true):
			editor.return_player()
		#throw error, lock encountered
	elif(node.get_filename() == port.get_path()):
		editor.prevLocation.x = editor.vars[0]["value"]
		editor.prevLocation.y = editor.vars[1]["value"]
		
		editor.vars[0]["value"] = node.dest.x
		editor.vars[1]["value"] = node.dest.y


func _on_Player_area_exited(area):
	var node = area.get_owner()
	if(node.get_filename() == input.get_path()):
		inputNode = null
