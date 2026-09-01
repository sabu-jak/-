class_name Card

var id: String
var name: String
var card_type: String  # "Melee", "Ranged", "Special"
var damage: float
var effect_description: String
var organ_slot: String  # Empty in phase 1

func _init(p_id: String, p_name: String, p_type: String, p_damage: float, p_effect: String):
	id = p_id
	name = p_name
	card_type = p_type
	damage = p_damage
	effect_description = p_effect
	organ_slot = ""

func _to_string() -> String:
	return "%s (%s) - DMG: %.1f" % [name, card_type, damage]
