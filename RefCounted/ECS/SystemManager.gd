## https://austinmorlan.com/posts/entity_component_system/
extends RefCounted
class_name SystemManager

var system_to_signature : Dictionary = {}
var id_to_system : Dictionary = {}

func register_system(new_system : System) -> void:
	id_to_system[new_system.get_instance_id()] = new_system

func set_signature(system : System, signature : int) -> void:
	assert(id_to_system.has(system.get_instance_id()))
	system_to_signature[system.get_instance_id()] = signature

func entity_destoryed(entity : int) -> void:
	for id in id_to_system.keys():
		id_to_system[id].entities.erase(entity)

func entity_signature_changed(entity : int, new_signature : int) -> void:
	for system in system_to_signature.keys():
		var system_sig = system_to_signature[system]
		if (new_signature & system_sig) == system_sig:
			id_to_system[system].entities.insert(entity)
		else:
			id_to_system[system].entities.erase(entity)

func update_systems(delta : float) -> void:
	for system in system_to_signature.keys():
		system.update(delta)
