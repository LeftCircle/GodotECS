## https://austinmorlan.com/posts/entity_component_system/
extends RefCounted
class_name ComponentArray

var components : Array = []
var entity_to_index : Dictionary = {}
var index_to_entity : Dictionary = {}
var size : int = 0

func _init() -> void:
	components.resize(EntityManager.MAX_ENTITIES)

func insert_data(entity : int, component : Variant) -> void:
	assert(!entity_to_index.has(entity), "Component added to same entity more than once.")
	var index : int = size
	entity_to_index[entity] = index
	index_to_entity[index] = entity
	components[index] = component
	size += 1

func remove_data(entity : int) -> void:
	assert(entity_to_index.has(entity), "Removing non-existent component.")
	var index : int = entity_to_index[entity]
	var last_entity : int = index_to_entity[size - 1]
	if components[index].is_class("Node"):
		components[index].queue_free()
	components[index] = components[size - 1]
	entity_to_index[last_entity] = index
	index_to_entity[index] = last_entity
	entity_to_index.erase(entity)
	index_to_entity.erase(size - 1)
	size -= 1

func get_data(entity : int) -> Variant:
	assert(entity_to_index.has(entity), "Retrieving non-existent component.")
	return components[entity_to_index[entity]]

func entity_destroyed(entity : int) -> void:
	if entity_to_index.has(entity):
		remove_data(entity)
