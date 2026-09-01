extends Node

# Game state
var game_time: float = 0.0
var max_time: float = 300.0  # 5분
var is_running: bool = false
var score: int = 0
var time_scale: float = 1.0

# Card system
var card_manager: CardManager

signal hand_updated
signal card_played(card: Card)

func _ready():
	print("Game Manager Initialized")
	card_manager = CardManager.new()
	card_manager.card_played.connect(_on_card_played)
	start_game()

func _process(delta):
	if is_running:
		game_time += delta * time_scale
		if game_time >= max_time:
			end_game()

func start_game():
	is_running = true
	game_time = 0.0
	score = 0
	print("Game Started")

func end_game():
	is_running = false
	print("Game Over! Final Score: ", score)

func add_score(points: int):
	score += points
	print("Score: ", score)

func get_time_remaining() -> float:
	return max(0, max_time - game_time)

func get_time_formatted() -> String:
	var minutes = int(get_time_remaining()) / 60
	var seconds = int(get_time_remaining()) % 60
	return "%02d:%02d" % [minutes, seconds]

func card_played(card: Card):
	add_score(int(card.damage))
	apply_card_effect(card)
	card_manager.play_card(card)
	hand_updated.emit()
	card_played.emit(card)

func apply_card_effect(card: Card):
	var player = get_parent().get_node("Player")
	var enemies = get_tree().get_nodes_in_group("enemies")

	var damage_range = 200.0
	for enemy in enemies:
		if enemy.global_position.distance_to(player.global_position) < damage_range:
			enemy.take_damage(card.damage)

	activate_time_dilation()

func activate_time_dilation():
	time_scale = 0.5
	await get_tree().create_timer(0.3).timeout
	time_scale = 1.0

func _on_card_played(card: Card):
	card_played.emit(card)
