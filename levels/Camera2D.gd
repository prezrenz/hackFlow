extends Camera2D

onready var level = get_parent()

var zoomMax = 2
var zoomMin = 0.4
var zoomStep = 0.1
var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)

func _input(event):
	if(event is InputEventMouseButton):
		if(event.is_action_pressed("view_pan_mouse")):
			dragging = true
		elif(event.is_action_released("view_pan_mouse")):
			dragging = false
		if(event.is_action_pressed("view_zoom_in")):
			zoom -= Vector2(zoomStep, zoomStep)
			zoom.x = clamp(zoom.x, zoomMin, zoomMax)
			zoom.y = clamp(zoom.y, zoomMin, zoomMax)
		if(event.is_action_pressed("view_zoom_out")):
			zoom += Vector2(zoomStep, zoomStep)
			zoom.x = clamp(zoom.x, zoomMin, zoomMax)
			zoom.y = clamp(zoom.y, zoomMin, zoomMax)
	if event is InputEventMouseMotion and dragging:
		position -= event.relative
