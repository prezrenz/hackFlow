extends PopupPanel

onready var nameList = $VBoxContainer/HSplitContainer/name
onready var valueList = $VBoxContainer/HSplitContainer/value
onready var editor = get_parent().get_node("Editor")

var valLabels = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in editor.vars.size():
		var nam = Label.new()
		var val = Label.new()
		
		nam.set_text(editor.vars[i]["name"])
		val.set_text(str(editor.vars[i]["value"]))
		
		nam.set_align(1)
		val.set_align(1)
		
		valLabels.merge({editor.vars[i]["name"]: val})
		
		nameList.add_child(nam)
		valueList.add_child(val)

func _process(_delta):
	for i in editor.vars.size():
		valLabels[editor.vars[i]["name"]].set_text(str(editor.vars[i]["value"]))

