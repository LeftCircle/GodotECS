@tool
extends EditorPlugin

var component_button : Button

func _enter_tree() -> void:
	component_button = preload("res://addons/lls_ecs/Scenes/Plugin/ComponentButton.tscn").instantiate()

	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, component_button)

func _exit_tree() -> void:
	remove_control_from_docks(component_button)
	component_button.free()

