extends Node2D

@export var character_scene : PackedScene

var x_range = 10000

func _ready() -> void:
	_init_falling_characters()

func _init_falling_characters() -> void:
	for i in range(500):
		var character = character_scene.instantiate()
		character.get_node("ECSCharacterBody2D").position = Vector2(randi_range(-x_range, x_range), 0)
		EcsCoordinator.add_component(character.entity_id, Move.new())
		add_child(character)



