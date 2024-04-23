extends GutTest


var component_resource_groups : ResourceGroup = load("res://Resources/ComponentResourceGroup.tres")

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
