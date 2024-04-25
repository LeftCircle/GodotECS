## https://austinmorlan.com/posts/entity_component_system/
extends RefCounted
class_name ComponentManager

var component_arrays : Dictionary = {}
var next_component_bit : int = 0
var class_id_to_script : Dictionary = {}
var script_to_class_id : Dictionary = {}
var script_to_signature : Dictionary = {}

func register_component(class_id : StringName, script : Script) -> void:
	assert(!component_arrays.has(script), "Component %s already registered." % [class_id])
	var bit_id = 1 << next_component_bit
	next_component_bit += 1
	var ca : ComponentArray = ComponentArray.new()
	component_arrays[script] = ca
	class_id_to_script[class_id] = script
	script_to_class_id[script] = class_id
	script_to_signature[script] = bit_id

## Returns the bit type of the component - used for creating signatures
func get_component_signature(script : Script) -> int:
	return script_to_signature[script]

func add_component(entity : int, component : Object) -> void:
	component_arrays[component.get_script()].insert_data(entity, component)

func remove_component(entity : int, script : Script) -> void:
	component_arrays[script].remove_data(entity)

func get_component(entity : int, script : Script) -> Object:
	return component_arrays[script].get_data(entity)

func entity_destoryed(entity : int) -> void:
	for component_array in component_arrays.values():
		component_array.entity_destroyed(entity)

func is_component_registered(script : Script) -> bool:
	return component_arrays.has(script)
