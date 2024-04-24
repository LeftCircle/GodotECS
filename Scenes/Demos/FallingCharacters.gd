extends Node2D

@export var character_scene : PackedScene

var x_range = 1000

func _ready() -> void:
	pass

func _init_falling_characters() -> void:
	for i in range(EntityManager.MAX_ENTITIES):
		var character = character_scene.instantiate()
		EcsCoordinator.add_component(character, Move)
		add_child(character)



