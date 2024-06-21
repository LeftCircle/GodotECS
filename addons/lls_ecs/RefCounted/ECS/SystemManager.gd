## https://austinmorlan.com/posts/entity_component_system/
extends RefCounted
class_name SystemManager

var system_to_signature : Dictionary = {}
var script_to_system : Dictionary = {}

func register_system(new_system : System) -> void:
	script_to_system[new_system.get_script()] = new_system

func set_signature(system : System, signature : int) -> void:
	assert(script_to_system.has(system.get_script()))
	system_to_signature[system] = signature

func entity_destroyed(entity : int) -> void:
	for system in system_to_signature.keys():
		system.entities.erase(entity)

func entity_signature_changed(entity : int, new_signature : int) -> void:
	for system in system_to_signature.keys():
		var system_sig = system_to_signature[system]
		if (new_signature & system_sig) == system_sig:
			system.entities[entity] = null
		else:
			system.entities.erase(entity)

func update_systems(delta : float) -> void:
	for system in system_to_signature.keys():
		system.update(delta)

func has_system(script : Script) -> bool:
	return script_to_system.has(script)
