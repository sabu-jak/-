extends Node

var cards: Array[Card] = []
var deck: Array[Card] = []
var hand: Array[Card] = []
var hand_size: int = 3
var card_ui_scene = preload("res://scenes/ui/card_ui.tscn")

signal card_selected(card: Card)
signal card_played(card: Card)

func _ready():
	initialize_deck()
	draw_hand()

func initialize_deck():
	cards = [
		Card.new("melee_1", "Slash", "Melee", 15.0, "Quick melee attack"),
		Card.new("melee_2", "Heavy Strike", "Melee", 25.0, "Slow but powerful melee"),
		Card.new("ranged_1", "Shoot", "Ranged", 12.0, "Quick ranged attack"),
		Card.new("ranged_2", "Snipe", "Ranged", 20.0, "Precise ranged attack"),
		Card.new("special_1", "Heal", "Special", 0.0, "Restore health"),
	]
	deck = cards.duplicate()
	deck.shuffle()

func draw_hand():
	hand.clear()
	var draw_count = min(hand_size, deck.size())
	for i in range(draw_count):
		hand.append(deck.pop_front())

func play_card(card: Card):
	hand.erase(card)
	card_played.emit(card)
	if deck.size() > 0:
		hand.append(deck.pop_front())

func get_hand() -> Array[Card]:
	return hand
