extends System
class_name MoveSystem

func update(delta : float) -> void:
	for entity in entities.keys():
		var move : Move = EcsCoordinator.get_component(entity, "MVE")

