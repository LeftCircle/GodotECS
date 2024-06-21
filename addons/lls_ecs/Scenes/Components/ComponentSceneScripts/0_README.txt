Component scenes are scenes from Godot that have some script functionality that
we want to use in a system. Something like a CharacterBody2D that has the
move_and_slide() function built into it.

In order for these scnees to work with the ECS, we have to have a workaround where
we stuff them into a resource so that we can register them as a component at the
start of the game.

These scripts are also a little funky because they have to be added to entities
via the editor, and they are responsible for adding themselves to the entity
via the ECSCoordinator.
