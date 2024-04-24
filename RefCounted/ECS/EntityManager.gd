## https://austinmorlan.com/posts/entity_component_system/
extends RefCounted
class_name EntityManager

const MAX_ENTITIES = 1000
const NULL_ID = -1

var available_ids : PackedInt32Array = []
var living_entities : int = 0
## a signiture containing a 64 bit bitfield for each component
var signatures : PackedInt64Array = []

func _init() -> void:
	for i in range(MAX_ENTITIES):
		available_ids.push_back(i)
		signatures.push_back(0)

func create_entity() -> int:
	assert(living_entities < MAX_ENTITIES, "Too many entities in existence.")
	var id : int = available_ids[0]
	available_ids.remove_at(0)
	living_entities += 1
	return id

func destroy_entity(entity : int) -> void:
	assert(entity < MAX_ENTITIES, "Entity out of range.")
	available_ids.push_back(entity)
	signatures.set(entity, 0)
	living_entities -= 1

func set_signature(entity : int, signature : int) -> void:
	assert(entity < MAX_ENTITIES, "Entity out of range.")
	signatures.set(entity, signature)

func get_signature(entity : int) -> int:
	assert(entity < MAX_ENTITIES, "Entity out of range.")
	return signatures[entity]
