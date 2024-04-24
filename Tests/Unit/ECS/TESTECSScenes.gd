extends GutTest

var component_scene_rg : ResourceGroup = load("res://Scenes/Components/ComponentSceneGroup.tres")
var ecs_cbd_ps : PackedScene = load("res://Scenes/Components/ComponentScenes/ECSCharacterBody2D.tscn")

func test_all_ecs_scenes_add_to_entity_on_ready() -> void:
	var test_entity = Entity.new()
	add_child_autofree(test_entity)
	var c_scenes : Array = []
	component_scene_rg.load_all_into(c_scenes)
	for packed_scene in c_scenes:
		var scene = packed_scene.instantiate()
		test_entity.add_child(scene)
		await get_tree().process_frame
		assert_true(EcsCoordinator.has_component(test_entity.entity_id, scene))
		scene.queue_free()

func test_remove_component_queues_free_if_scene() -> void:
	var test_entity = Entity.new()
	add_child_autofree(test_entity)
	var c_scenes : Array = []
	component_scene_rg.load_all_into(c_scenes)
	for packed_scene in c_scenes:
		var scene = packed_scene.instantiate()
		test_entity.add_child(scene)
		await get_tree().process_frame
		EcsCoordinator.remove_component(test_entity.entity_id, scene)
		assert_true(scene.is_queued_for_deletion())
		assert_false(EcsCoordinator.has_component(test_entity.entity_id, scene))

func test_entity_id_increments_on_entity_creation() -> void:
	var entity1 = Entity.new()
	var entity2 = Entity.new()
	assert_ne(entity1.entity_id, entity2.entity_id)

func test_get_class() -> void:
	var ecs_cbd : ECSCharacterBody2D = ecs_cbd_ps.instantiate()
	assert_true(ecs_cbd is ECSCharacterBody2D)
	assert_eq(ECSCharacterBody2D, ecs_cbd.get_script())
	print(type_string(typeof(ECSCharacterBody2D)))
	ecs_cbd.free()

