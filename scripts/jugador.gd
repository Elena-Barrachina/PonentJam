extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 1000

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var input_dir = 0

	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1

	velocity.x = input_dir * SPEED

	move_and_slide()

	# TODO: Use proper jump dynamics
	print(velocity.y)
	if Input.is_action_just_pressed("ui_up") and velocity.y == 0:
		velocity.y = JUMP_FORCE
	
	velocity.y += GRAVITY * delta

	if anim:
		if input_dir != 0:
			anim.animation = "Correr"
			anim.flip_h = input_dir < 0
		else:
			anim.animation = "Parado"
