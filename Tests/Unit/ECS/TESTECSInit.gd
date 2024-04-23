extends GutTest

var comp_rg : ResourceGroup = load("res://Resources/ComponentResourceGroup.tres")
var sys_rg : ResourceGroup = load("res://Resources/SystemResourceGroup.tres")


func test_systems_are_registered() -> void:
	# Check to see if all of the components are registered to the component system.
	var components = []
	comp_rg.load_all_into(components)
	for comp in components:
		assert_true(EcsCoordinator.is_component_registered(comp.class_id), "%s not registered!!" % [comp.class_id])

func test_components_are_registered() -> void:
	assert_true(false, "Not implemented")
