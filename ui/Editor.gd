extends PopupPanel

onready var root = get_tree().get_current_scene()
onready var errorHandler = root.get_node("GameUI/Error")
onready var text = $VBoxContainer/TextEdit
onready var player = root.find_node("Player")

var vars = []
var varCount = 0
var label = {}
var labelPos = 0
var curPos = 0
var prevLocation = Vector2(0,0)
var playerLocation = Vector2(0,0)

var cmds = ["inc",
			"dec",
			"rst",
			"stor",
			"emit",
			"jeq",
			"jlt",
			"jgt",
			"jmp"]

func _ready():
	vars.insert(varCount, {"name": "x", "value": 0, "type": "special"})
	varCount += 1
	vars.insert(varCount, {"name": "y", "value": 0, "type": "special"})
	varCount += 1
	vars.insert(varCount, {"name": "cnt", "value": 0, "type": "integer"})
	varCount += 1
	vars.insert(varCount, {"name": "str", "value": 0, "type": "string"})
	varCount += 1
	vars.insert(varCount, {"name": "int", "value": 0, "type": "integer"})
	varCount += 1

func _process(_delta):
	playerLocation.x = vars[0]["value"]
	playerLocation.y = vars[1]["value"]
	
	vars[0]["value"] = clamp(vars[0]["value"], 0, 15-1)
	vars[1]["value"] = clamp(vars[1]["value"], 0, 10-1)

func reset():
	label = {}
	labelPos = 0
	curPos = 0
	# text.cursor_set_line(curPos)
	root.reset_game()
	
	for i in vars:
		i["value"] = 0

func execute(cmd, arg1, arg2, arg3):
	if(cmd == "inc"):
		var found = false
		for i in vars.size():
			#THERE HAS TO BE A BETTER WAY
			if(vars[i]["name"] == arg1):
				found = true
				if(arg1 == "x"):
					prevLocation.x = vars[i]["value"]
					vars[i]["value"] += 1
				elif(arg1 == "y"):
					prevLocation.y = vars[i]["value"]
					vars[i]["value"] += 1
				else:
					vars[i]["value"] += 1
		
		if(!found):
			var errorText = "Invalid Arguement: variable %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
	
	elif(cmd == "dec"):
		var found = false
		for i in vars.size():
			if(vars[i]["name"] == arg1):
				found = true
				if(arg1 == "x"):
					prevLocation.x = vars[i]["value"]
					vars[i]["value"] -= 1
				elif(arg1 == "y"):
					prevLocation.y = vars[i]["value"]
					vars[i]["value"] -= 1
				else:
					vars[i]["value"] -= 1
		
		if(!found):
			var errorText = "Invalid Arguement: variable %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
	
	elif(cmd == "rst"):
		vars[2].value = 0
#		var found = false
#		for i in vars.size():
#			if(vars[i]["name"] == arg1):
#				found = true
#				vars[i]["value"] = 0
#
#		if(!found):
#			var errorText = "Invalid Arguement: variable %s not found!" % arg1
#			errorHandler.error(errorText, text.get_line(curPos), curPos)
	
	elif(cmd == "emit"):
		var unlocked = false
		for i in vars.size():
			if(vars[i]["name"] == arg1):
				unlocked = player.unlock(vars[i])
		if(!unlocked):
			var errorText = "Mismatch: Failed to open lock, wrong key!"
			errorHandler.error(errorText, text.get_line(curPos), curPos)
	
	elif(cmd == "stor"):
		var found = false
		for i in vars.size():
			if(vars[i]["name"] == arg1):
				found = true
				var overlaps = player.get_overlapping_areas()
				
				if overlaps.empty():
					var errorText = "No Input Data in position!"
					errorHandler.error(errorText, text.get_line(curPos), curPos)
				else:
					var node = overlaps[0].get_parent()
					
					if node.type == vars[i]["type"]:
						if vars[i]["type"] == "string":
							vars[i]["value"] = node.strDat
						elif vars[i]["type"] == "integer":
							vars[i]["value"] = node.intDat
					else:
						var errorText = "Mismatch: variable %s is of different Data Type than input!" % arg1
						errorHandler.error(errorText, text.get_line(curPos), curPos)
					node.hide()
		if(!found):
			var errorText = "Invalid Arguement: Variable %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
		
	elif(cmd == "jeq"):
		var foundLabel = false
		var foundVar = false
		for i in label.size():
			if(label.has(arg3)):
				foundLabel = true
				for i2 in vars.size():
					if(vars[i2]["name"] == arg1):
						foundVar = true
						if(int(arg2) == vars[i2]["value"]):
							curPos = label[arg3] - 1
		
		if(!foundLabel):
			var errorText = "Invalid Arguement: label %s not found!" % arg3
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
		elif(!foundVar):
			var errorText = "Invalid Arguement: variable %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
			
	elif(cmd == "jlt"):
		var foundLabel = false
		var foundVar = false
		for i in label.size():
			if(label.has(arg3)):
				foundLabel = true
				for i2 in vars.size():
					if(vars[i2]["name"] == arg1):
						foundVar = true
						if(vars[i2]["value"] < int(arg2)):
							curPos = label[arg3] - 1
		
		if(!foundLabel):
			var errorText = "Invalid Arguement: label %s not found!" % arg3
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
		elif(!foundVar):
			var errorText = "Invalid Arguement: variable %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
		
	elif(cmd == "jgt"):
		var foundLabel = false
		var foundVar = false
		for i in label.size():
			if(label.has(arg3)):
				foundLabel = true
				for i2 in vars.size():
					if(vars[i2]["name"] == arg1):
						foundVar = true
						if(vars[i2]["value"] > int(arg2)):
							curPos = label[arg3] - 1
		
		if(!foundLabel):
			var errorText = "Invalid Arguement: label %s not found!" % arg3
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
		elif(!foundVar):
			var errorText = "Invalid Arguement: variable %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
		
	elif(cmd == "jmp"):
		var found = false
		for i in label.size():
			if(label.has(arg1)):
				found = true
				curPos = label[arg1] - 1
		
		if(!found):
			var errorText = "Invalid Arguement: label %s not found!" % arg1
			errorHandler.error(errorText, text.get_line(curPos), curPos)
			return
	
	else:
		var errorText = "Invalid Command: command %s does not exist!" % arg1
		errorHandler.error(errorText, text.get_line(curPos), curPos)
		return


func _on_Step_button_up():
	for i in text.get_line_count():
		var line = text.get_line(i)
		if(';' in line):
			label.merge({line.get_slice(';',1): i}, true)
	text.cursor_set_line(curPos)
	#If line is not in command, should throw error, reset for now
	#If empty line means no NOP, throw error too, but reset for now
	var line = text.get_line(curPos)
	
	if(line.empty()):
		root.winStatus.set_status(false)
		return
	
	if(';' in line):
		curPos += 1
		return
	
	var cmd = line.get_slice(" ", 0)

	if(cmds.find(cmd) < 0):
		var errorText = "Invalid Command: command %s does not exist!" % cmd
		errorHandler.error(errorText, text.get_line(curPos), curPos)
		return
	
	var arg1 = line.get_slice(" ", 1)
	var arg2 = line.get_slice(" ", 2)
	var arg3 = line.get_slice(" ", 3)
	
	execute(cmd.to_lower(), arg1.to_lower(), arg2.to_lower(), arg3.to_lower())
	
	if(cmd != "nop"):
		curPos += 1
	

func return_player():
	vars[0]["value"] = prevLocation.x
	vars[1]["value"] = prevLocation.y

func _on_Reset_button_up():
	reset()

func _on_TextEdit_text_changed():
	if(curPos > 0):
		reset()
