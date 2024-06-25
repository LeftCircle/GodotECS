@tool
extends EditorPlugin

# Singletons ---------------
const ECS_COORDINATOR_NAME = "EcsCoordinator"
const ECS_INIT_NAME = "EcsInitializer"
#---------------------------
# Docks ---------------------
var creation_dock : Control

# ---------------------------

func _enter_tree() -> void:
	add_singletons()
	add_docks()

func _exit_tree() -> void:
	remove_control_from_docks(creation_dock)
	remove_docks()

func add_singletons() -> void:
	add_autoload_singleton(ECS_COORDINATOR_NAME, "res://addons/lls_ecs/Singletons/ECS/ECSCoordinator.gd")
	add_autoload_singleton(ECS_INIT_NAME, "res://addons/lls_ecs/Singletons/ECS/ECSInitializer.tscn")

func add_docks() -> void:
	creation_dock = preload("res://addons/lls_ecs/Scenes/Plugin/CreationDock.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, creation_dock)

func remove_singletons() -> void:
	remove_autoload_singleton(ECS_COORDINATOR_NAME)
	remove_autoload_singleton(ECS_INIT_NAME)

func remove_docks() -> void:
	creation_dock.free()
