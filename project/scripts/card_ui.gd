extends Panel

var card: Card
var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _ready():
	gui_input.connect(_on_gui_input)
	modulate = Color(0.2, 0.3, 0.5, 0.9)

func set_card(p_card: Card):
	card = p_card
	if has_node("Title"):
		$Title.text = card.name
	if has_node("Type"):
		$Type.text = card.card_type
	if has_node("Damage"):
		$Damage.text = "DMG: %.0f" % card.damage

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = true
			drag_offset = get_global_mouse_position() - global_position
			get_tree().get_root().move_child(self, -1)
		elif not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = false
			on_card_released()

func _process(delta):
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset
		get_tree().root.get_child(0).modulate.v = 0.5  # Time dilation visual

func on_card_released():
	var game_manager = get_tree().root.get_child(0).get_node("GameManager")
	game_manager.card_played(card)
