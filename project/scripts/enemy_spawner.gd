extends Node

var enemy_scene = preload("res://scenes/enemies/basic_enemy.tscn")
var spawn_timer: float = 0.0
var spawn_interval: float = 3.0
var game_manager: Node

func _ready():
	game_manager = get_tree().root.get_child(0).get_node("GameManager")

func _process(delta):
	if not game_manager.is_running:
		return

	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_enemy()
		spawn_timer = 0.0
		spawn_interval = max(1.0, spawn_interval - 0.05)

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var player = game_manager.get_parent().get_node("Player")
	var offset = Vector2(randf_range(-300, 300), randf_range(-300, 300))
	enemy.global_position = player.global_position + offset
	get_tree().root.get_child(0).add_child(enemy)
