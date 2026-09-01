extends CharacterBody2D

# Movement
var speed: float = 200.0
var current_velocity: Vector2 = Vector2.ZERO

# Input
var input_direction: Vector2 = Vector2.ZERO

func _ready():
	print("Player Initialized")

func _physics_process(delta):
	handle_input()
	update_velocity()
	velocity = current_velocity
	move_and_slide()

func handle_input():
	input_direction = Input.get_vector("ui_move_left", "ui_move_right", "ui_move_up", "ui_move_down")

	if Input.is_action_just_pressed("ui_dodge"):
		dodge()

func update_velocity():
	current_velocity = input_direction.normalized() * speed

func dodge():
	print("Dodge!")
	# TODO: 회피 로직 구현
