# Godot ECS Demo

This is gdscript implementation of an entity component system with Godot, heavily influenced by [this article from Austin Morlin](https://austinmorlan.com/posts/entity_component_system/). Game data is stored in different component arrays, where each component array consists of just a single type of component, and each index in the array corresponds to a given entity. Gameplay logic is driven by systems that iterate over all entities registered to them, then operate on the data within the component arrays associated with the system. 

## Usage

### The Entity
Entities extend Node, which allows us to add things that are not purely just data such as Sprites to the entity. An entity is created by creating a new scene of type Entity. All required components for the entity are then added by code via 
`EcsCoordinator.add_component(entity : int, component : Object)`. Any component that is added via the editor must be a [Component Scene](#ComponentScenes) in order to be added to the Component Manager

## Components
Components are resources that are added to the Resources -> Components folder. They must be added to this folder so that the ComponentResourceGroup registers the component at the start of the game. Components extend the Component resource, and are simply data containers with no functionality. They are used to store data that is used and updated for gameplay. 

### ComponentScenes
Component Scenes are very similar to components, but they extend Godot scenes such as CharacterBody2D. This is because we might want some functionality that Godot classes provide, such as CharacterBody2D.move_and_slide(). To use move_and_slide() in a system, a create an ECSCharacterBody2D scene that extends CharacterBody2D and place the scene in Scenes -> Components -> ComponentScenes. The node must have the following in their _ready() function:
```
func _ready() -> void:
    var entity_id : int = get_parent().entity_id
    EcsCoordinator.add_component(entity_id, self)
```
If you forget to add this, the scene will not be registered to the component manager, but there is a unit test to ensure that all scenes in the ComponentScenes folder are registered. Don't forget to run your unit tests!

### Systems
Systems are responsible for all of the gameplay logic. Each physics step, the EcsCoordinator loops through all systems and calls their update function. 

Systems are resources that extend the System Resource, and are placed in Resources -> System. Systems have an export variable of their required components. Add however many components are needed for the system by dragging and dropping the component resource or compoennt scene into the array in the editor (select Object from the dropdown when you add an element). This will be used to create a signature for the system so that entities are automatically added to/removed from the system when they have/no longer have the required components for the system. 

Systems must also have an update function where that operates on all entities within the system. instead of using EcsCoordinator.get_component(entity, component), it is _much_ faster to create a reference to the ComponentArray you want to access, then to pull directly from that when iterating over all entities in the system. The MoveSystem should act as a good reference for creating nerw systems. 
