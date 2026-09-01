extends Node

# Game state
var game_time: float = 0.0
var max_time: float = 300.0  # 5분
var is_running: bool = false
var score: int = 0

func _ready():
	print("Game Manager Initialized")
	start_game()

func _process(delta):
	if is_running:
		game_time += delta
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
