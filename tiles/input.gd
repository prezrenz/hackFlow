extends Sprite

var tileName = "input"

export(int) var intDat
export(String, "string", "integer") var type
export(String) var strDat

onready var panel = $PanelContainer
onready var values = $PanelContainer/Values
onready var datas = $PanelContainer/Values/Datas
onready var area = $Area2D

var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#area.set_pickable(true)
	
	var datType = Label.new()
	var data = Label.new()
		
	datType.set_text(type)
	if(type == "string"):
		data.set_text(strDat)
	else:
		data.set_text(str(intDat))
		
	datas.add_child(data)
	datas.add_child(datType)

#func _process(delta):
#	if((entered) and (Input.is_mouse_button_pressed(BUTTON_LEFT))):
#		print(entered)
#		if !popup.visible:
#			popup.show()
#		elif popup.visible:
#			popup.hide()

#
#func _on_Area2D_mouse_entered():
#	entered = true
#	print("Yes")
#	print(entered)
#
#
#func _on_Area2D_mouse_exited():
#	entered = false
#	print(entered)

func _on_PanelContainer_mouse_entered():
	panel.show()
	print("yes")


func _on_PanelContainer_mouse_exited():
	panel.hide()
