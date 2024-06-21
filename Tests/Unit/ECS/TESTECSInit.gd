extends GutTest

var comp_rg : ResourceGroup = load("res://addons/lls_ecs/Resources/ComponentResourceGroup.tres")
var sys_rg : ResourceGroup = load("res://addons/lls_ecs/Resources/SystemResourceGroup.tres")
var scene_rg : ResourceGroup = load("res://addons/lls_ecs/Scenes/Components/ComponentSceneGroup.tres")

func test_components_are_registered() -> void:
	# Check to see if all of the components are registered to the component system.
	var components = []
	comp_rg.load_all_into(components)
	for comp in components:
		assert_true(EcsCoordinator.is_component_registered(comp.get_script()), "%s not registered!!" % [comp.class_id])

func test_scenes_are_registerd() -> void:
	var scenes = []
	scene_rg.load_all_into(scenes)
	for packed_scene in scenes:
		var scene = packed_scene.instantiate()
		assert_true(EcsCoordinator.is_component_registered(scene.get_script()), "%s not registered!!" % [scene.to_string()])

func test_systems_are_registered() -> void:
	var systems = []
	sys_rg.load_all_into(systems)
	for sys in systems:
		assert_true(EcsCoordinator.is_system_registered(sys.get_script()), "%s not registered!!" % [sys.to_string()])
