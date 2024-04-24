extends Node


var component_manager = ComponentManager.new()
var entity_manager = EntityManager.new()
var system_manager = SystemManager.new()

func create_entity() -> int:
	return entity_manager.create_entity()

func destroy_entity(entity: int) -> void:
	entity_manager.destroy_entity(entity)
	component_manager.entity_destroyed(entity)
	system_manager.entity_destroyed(entity)

func register_component(component: Object) -> void:
	component_manager.register_component(component.class_id)

func add_component(entity: int, component: Object) -> void:
	component_manager.add_component(entity, component)
	var signature : int = entity_manager.get_signature(entity)
	signature = signature | component_manager.get_component_signature(component.class_id)
	entity_manager.set_signature(entity, signature)
	system_manager.entity_signature_changed(entity, signature)

func remove_component(entity: int, component: Object) -> void:
	component_manager.remove_component(entity, component)
	var signature : int = entity_manager.get_signature(entity)
	signature = signature & ~component_manager.get_component_signature(component.class_id)
	entity_manager.set_signature(entity, signature)
	system_manager.entity_signature_changed(entity, signature)

func get_component(entity: int, class_id : StringName) -> Component:
	return component_manager.get_component(entity, class_id)

func get_component_signature(class_id : StringName) -> int:
	return component_manager.get_component_signature(class_id)

func register_system(system: System) -> void:
	system_manager.register_system(system)
	var signature : int = 0
	for component in system.required_components:
		signature = signature | component_manager.get_component_signature(component.class_id)
	system_manager.set_signature(system, signature)

func is_component_registered(class_id : StringName) -> bool:
	return component_manager.is_component_registered(class_id)

func has_component(entity: int, component : Object) -> bool:
	var signature : int = entity_manager.get_signature(entity)
	var component_signature : int = component_manager.get_component_signature(component.class_id)
	return (signature & component_signature) == component_signature

func update_systems(delta: float) -> void:
	system_manager.update_systems(delta)
