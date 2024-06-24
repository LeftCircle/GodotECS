@tool
extends Button

func _enter_tree() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	print("Pressed")
