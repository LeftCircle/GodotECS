extends System
class_name MoveSystem

var move_arrays : ComponentArray = EcsCoordinator.component_manager.component_arrays[Move]
var character_body_arrays : ComponentArray = EcsCoordinator.component_manager.component_arrays[ECSCharacterBody2D]

func update(delta : float) -> void:
	for entity in entities.keys():
		var move : Move = move_arrays.components[move_arrays.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = character_body_arrays.components[character_body_arrays.entity_to_index[entity]]
		move.velocity = Vector2(0, 100)
		cbd.velocity = move.velocity
		cbd.move_and_slide()
		move.velocity = cbd.velocity
		move.global_position = cbd.global_position


