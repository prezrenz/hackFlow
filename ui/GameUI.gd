extends Control

onready var editor = $Editor
onready var varList = $Variables

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
