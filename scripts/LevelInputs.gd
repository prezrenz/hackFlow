extends Resource
class_name LevelInputs

export(int) var intDat
export(String, "string", "integer") var type
export(String) var strDat

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_intDat = 0, p_type = "string", p_strDat = " "):
	var intDat = p_intDat
	var type = p_type
	var strDat = p_strDat
