
extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var jumps_left = 2

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps_left = 2

	# Handle jump
	if Input.is_action_just_pressed("jump") and jumps_left > 0 and Globals.player_can_move:
		$"AudioStreamPlayer2D".play()
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	# Get input direction
	var direction := Input.get_axis("left", "right")

	if Globals.player_can_move:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not Globals.player_stop_slide:
		move_and_slide()


func _process(_delta: float) -> void:
	if global_position.y >= 1000:
		get_tree().reload_current_scene()
	if Globals.win and is_on_floor():
		Globals.player_can_move = false


func _ready() -> void:
	$"AnimatedSprite2D".play("idle")
	Globals.player_can_move = true
	Globals.player_stop_slide = false
