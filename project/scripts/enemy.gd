extends CharacterBody2D

class_name Enemy

var enemy_type: String
var health: float = 30.0
var max_health: float = 30.0
var speed: float = 100.0
var damage: float = 5.0
var player: Node2D

func _ready():
	player = get_tree().root.get_child(0).get_node("Player")
	add_to_group("enemies")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func take_damage(amount: float):
	health -= amount
	if health <= 0:
		die()

func die():
	var game_manager = get_tree().root.get_child(0).get_node("GameManager")
	game_manager.add_score(10)
	queue_free()
