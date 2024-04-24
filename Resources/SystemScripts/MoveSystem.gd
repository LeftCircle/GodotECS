extends System
class_name MoveSystem

func update(delta : float) -> void:
	for entity in entities.keys():
		var move : Move = EcsCoordinator.get_component(entity, Move)
		var cbd : ECSCharacterBody2D = EcsCoordinator.get_component(entity, ECSCharacterBody2D)
		move.velocity = Vector2(0, 100)
		cbd.velocity = move.velocity
		cbd.move_and_slide()
		move.velocity = cbd.velocity
		move.global_position = cbd.global_position


