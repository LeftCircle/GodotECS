extends Button

@export_dir var script_dir : String
@export_dir var resource_dir : String

@export var popup_scene : PackedScene

func _enter_tree() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	print("Pressed")
	var popup = popup_scene.instantiate()
	add_child(popup)
