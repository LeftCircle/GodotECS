extends Node
class_name Entity

var entity_id : int = EntityManager.NULL_ID

func _init() -> void:
	entity_id = EcsCoordinator.create_entity()
