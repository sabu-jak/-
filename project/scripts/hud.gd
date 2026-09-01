extends CanvasLayer

func _ready():
	var timer_label = Label.new()
	timer_label.name = "TimerLabel"
	timer_label.anchor_left = 0.0
	timer_label.anchor_top = 0.0
	timer_label.anchor_right = 0.2
	timer_label.anchor_bottom = 0.1
	add_child(timer_label)

	var score_label = Label.new()
	score_label.name = "ScoreLabel"
	score_label.anchor_left = 0.0
	score_label.anchor_top = 0.1
	score_label.anchor_right = 0.2
	score_label.anchor_bottom = 0.2
	add_child(score_label)

func _process(delta):
	var game_manager = get_tree().root.get_child(0).get_node("GameManager")
	if has_node("TimerLabel"):
		$TimerLabel.text = "Time: " + game_manager.get_time_formatted()
	if has_node("ScoreLabel"):
		$ScoreLabel.text = "Score: " + str(game_manager.score)
