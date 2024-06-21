extends Node

@export var component_groups : ResourceGroup
@export var system_groups : ResourceGroup
@export var compont_scene_rg : ResourceGroup

func _ready() -> void:
	_initialize_components()
	_intialize_component_scenes()
	_initialize_systems()
	queue_free()

func _initialize_components() -> void:
	var components : Array = []
	component_groups.load_all_into(components)
	for component in components:
		EcsCoordinator.register_component(component)

func _intialize_component_scenes() -> void:
	var component_scenes : Array = []
	compont_scene_rg.load_all_into(component_scenes)
	for packed_scene in component_scenes:
		var scene = packed_scene.instantiate()
		EcsCoordinator.register_component(scene)
		scene.queue_free()

func _initialize_systems() -> void:
	var systems : Array = []
	system_groups.load_all_into(systems)
	for system in systems:
		EcsCoordinator.register_system(system)
