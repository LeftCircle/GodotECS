extends GutTest


var component_resource_groups : ResourceGroup = load("res://addons/lls_ecs/Resources/ComponentResourceGroup.tres")
var scene_rg : ResourceGroup = load("res://addons/lls_ecs/Scenes/Components/ComponentSceneGroup.tres")

func test_move_has_class_id() -> void:
	var resources = []
	component_resource_groups.load_all_into(resources)
	var has_move = false
	for resource in resources:
		if resource.class_id == "MVE":
			has_move = true
		assert_true(resource.class_id != "")
	assert_true(has_move)

func test_no_class_id_is_unique() -> void:
	var resources = []
	component_resource_groups.load_all_into(resources)
	var class_ids = []
	for resource in resources:
		assert_true(resource.class_id != "")
		assert_true(not class_ids.has(resource.class_id))
		class_ids.append(resource.class_id)

func test_cbd_in_scene_resource_group() -> void:
	var scenes = []
	scene_rg.load_all_into(scenes)
	var has_cbd = false
	for scene in scenes:
		var i_scene = scene.instantiate()
		if i_scene.class_id == "CBD":
			has_cbd = true
		assert_true(i_scene.class_id != "")
		i_scene.free()
	assert_true(has_cbd)

func test_check_for_is_scene() -> void:
	var resource_c : Array = []
	component_resource_groups.load_all_into(resource_c)
	var scene_c : Array = []
	scene_rg.load_all_into(scene_c)
	for res in resource_c:
		## assert that the resource is not of node or inherits from node
		assert_false(res.is_class("Node"))
	for packed_scene in scene_c:
		var scene = packed_scene.instantiate()
		assert_true(scene.is_class("Node"))

