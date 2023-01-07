extends Sprite

var tileName = "input"

export(int) var intDat
export(String, "string", "integer") var type
export(String) var strDat

onready var root = get_tree().get_root().get_node("Game")

onready var panel = $Panel
onready var labels = $Panel/Labels
#onready var datas = $PanelContainer/Values/Datas
onready var area = $Area2D
onready var collider = $Area2D/CollisionShape2D

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
		
	labels.add_child(data)
	labels.add_child(datType)
	
	root.connect("toggleData", self, "toggle_data")
	add_to_group("tiles")

func _process(_delta):
	pass

func toggle_data():
	if(!panel.visible):
		panel.show()
	else:
		panel.hide()

