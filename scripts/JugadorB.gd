extends CharacterBody2D

const SPEED = 300.0
const JUMP_FORCE = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	# Apply gravity
	#if not is_on_floor():
		#velocity.y += gravity * delta
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_FORCE

	# Horizontal movement
	var input_dir = Input.get_axis("ui_left", "ui_right")
	if input_dir:
		velocity.x = input_dir + SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Jump
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("move_jump")) and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()

	# Animation
	if input_dir != 0:
		anim.animation = "correr"
		anim.flip_h = input_dir < 0  # flip if moving left
	else:
		anim.animation = "parado"
