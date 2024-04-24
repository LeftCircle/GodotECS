extends Node


var component_manager = ComponentManager.new()
var entity_manager = EntityManager.new()
var system_manager = SystemManager.new()

func _physics_process(delta: float) -> void:
	update_systems(delta)

func create_entity() -> int:
	return entity_manager.create_entity()

func destroy_entity(entity: int) -> void:
	entity_manager.destroy_entity(entity)
	component_manager.entity_destroyed(entity)
	system_manager.entity_destroyed(entity)

func register_component(component: Object) -> void:
	component_manager.register_component(component.class_id, component.get_script())

func add_component(entity: int, component: Object) -> void:
	component_manager.add_component(entity, component)
	var signature : int = entity_manager.get_signature(entity)
	signature = signature | component_manager.get_component_signature(component.get_script())
	entity_manager.set_signature(entity, signature)
	system_manager.entity_signature_changed(entity, signature)

func remove_component(entity: int, script: Script) -> void:
	component_manager.remove_component(entity, script)
	var signature : int = entity_manager.get_signature(entity)
	signature = signature & ~component_manager.get_component_signature(script)
	entity_manager.set_signature(entity, signature)
	system_manager.entity_signature_changed(entity, signature)

func get_component(entity: int, script : Script):
	return component_manager.get_component(entity, script)

func get_component_signature(script : Script) -> int:
	return component_manager.get_component_signature(script)

func register_system(system: System) -> void:
	system_manager.register_system(system)
	var signature : int = 0
	for component in system.required_components:
		if component is PackedScene:
			component = component.instantiate()
		signature = signature | component_manager.get_component_signature(component.get_script())
		if component.is_class("Node"):
			component.queue_free()
	system.required_components.clear()
	system_manager.set_signature(system, signature)

func is_component_registered(script : Script) -> bool:
	return component_manager.is_component_registered(script)

func is_system_registered(script: Script) -> bool:
	return system_manager.has_system(script)

func has_component(entity: int, script : Script) -> bool:
	var signature : int = entity_manager.get_signature(entity)
	var component_signature : int = component_manager.get_component_signature(script)
	return (signature & component_signature) == component_signature

func update_systems(delta: float) -> void:
	system_manager.update_systems(delta)
