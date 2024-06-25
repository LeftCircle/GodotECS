extends GutTest


## This should test that singletons are added via the plugin, not project settings
func test_plugin_singletons_are_loaded() -> void:
	assert_true(is_instance_valid(EcsCoordinator))
