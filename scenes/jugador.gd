extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 1000

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var input_dir = 0

	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		input_dir -= 1

	velocity.x = input_dir * SPEED

	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("move_jump")) and is_on_floor():
		velocity.y = JUMP_FORCE

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	move_and_slide()

	if anim:
		if input_dir != 0:
			anim.animation = "Correr"
			anim.flip_h = input_dir < 0
		else:
			anim.animation = "Parado"
