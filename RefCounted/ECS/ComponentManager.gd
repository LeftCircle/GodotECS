## https://austinmorlan.com/posts/entity_component_system/
extends RefCounted
class_name ComponentManager

var component_arrays : Dictionary = {}
var next_component_bit : int = 0
var class_id_to_bit_type : Dictionary = {}
var bit_id_to_class_id : Dictionary = {}
var class_id_to_script : Dictionary = {}

func get_component_array(script : Script) -> ComponentArray:
	return component_arrays[script]

func register_component(class_id : StringName, script : Script) -> void:
	assert(!class_id_to_bit_type.has(class_id), "Component %s already registered." % [class_id])
	var bit_id = 1 << next_component_bit
	next_component_bit += 1
	class_id_to_bit_type[class_id] = bit_id
	component_arrays[class_id] = ComponentArray.new()
	bit_id_to_class_id[bit_id] = class_id

## Returns the bit type of the component - used for creating signatures
func get_component_signature(class_id : StringName) -> int:
	return class_id_to_bit_type[class_id]

func add_component(entity : int, component : Object) -> void:
	get_component_array(component.class_id).insert_data(entity, component)

func remove_component(entity : int, component : Object) -> void:
	get_component_array(component.class_id).remove_data(entity)
	if component.is_class("Node"):
		component.queue_free()

func get_component(entity : int, class_id : StringName) -> Object:
	return get_component_array(class_id).get_data(entity)

func entity_destoryed(entity : int) -> void:
	for component_array in component_arrays.values():
		component_array.entity_destroyed(entity)

func is_component_registered(class_id : StringName) -> bool:
	return class_id_to_bit_type.has(class_id)
