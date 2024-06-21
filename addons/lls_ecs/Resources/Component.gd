extends Resource
class_name Component

var class_id : StringName : set = set_class_id
var instance_id : int

func set_class_id(new_id : StringName) -> void:
	class_id = new_id.substr(0, 3)

func _init() -> void:
	_init_class_id()

func _init_class_id() -> void:
	assert(false, "Must be overwritten")
