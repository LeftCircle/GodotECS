extends System
## The Move System is an example system for moving entities that have a Move component and a
## ECSCharacterBody2D component.
class_name MoveSystem

## Component arrays are added when the system is created. These arrays
## are pointers to the arrays in the ComponentManager. This prevents us having to return the array
## each time we grab a component during an update
var move_array : ComponentArray = EcsCoordinator.get_component_array(Move)
var character_body_array : ComponentArray = EcsCoordinator.get_component_array(ECSCharacterBody2D)

## The update will look through all entities, then directly querry the component_arrays for the component
## as opposed to calling get_data(). This reduces the number of function calls and greatly increases
## performance
func update(delta : float) -> void:
	for entity in entities.keys():
		var move : Move = move_array.components[move_array.entity_to_index[entity]]
		var cbd : ECSCharacterBody2D = character_body_array.components[character_body_array.entity_to_index[entity]]
		move.velocity = Vector2(0, 100)
		cbd.velocity = move.velocity
		cbd.move_and_slide()
		move.velocity = cbd.velocity
		move.global_position = cbd.global_position


