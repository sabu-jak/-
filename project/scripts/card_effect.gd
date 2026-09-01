extends Area2D

class_name CardEffect

var damage: float = 0.0
var card: Card
var duration: float = 0.5

func _ready():
	area_entered.connect(_on_area_entered)
	await get_tree().create_timer(duration).timeout
	queue_free()

func _on_area_entered(area):
	if area is Enemy:
		area.take_damage(damage)
