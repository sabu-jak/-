extends HBoxContainer

var card_ui_scene = preload("res://scenes/ui/card_ui.tscn")
var card_uis: Array = []

func _ready():
	var game_manager = get_tree().root.get_child(0).get_node("GameManager")
	game_manager.connect("hand_updated", Callable(self, "_on_hand_updated"))
	update_hand()

func update_hand():
	var game_manager = get_tree().root.get_child(0).get_node("GameManager")
	var hand = game_manager.card_manager.get_hand()

	clear_cards()
	for card in hand:
		var card_ui = card_ui_scene.instantiate()
		card_ui.set_card(card)
		add_child(card_ui)
		card_uis.append(card_ui)

func clear_cards():
	for card_ui in card_uis:
		card_ui.queue_free()
	card_uis.clear()

func _on_hand_updated():
	update_hand()
