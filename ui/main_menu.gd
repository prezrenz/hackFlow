extends ColorRect

onready var credits = $credits


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_Credits_pressed():
	credits.popup_centered()


func _on_Quit_pressed():
	get_tree().quit()
