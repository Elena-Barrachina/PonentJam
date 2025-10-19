extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 1000

@onready var anim = $AnimatedSprite2D
@onready var pasos = $pasos_audio
@onready var flames_num = get_tree().get_first_node_in_group("flames_num")

func _ready():
	add_to_group("player")
	update_ui()

func _physics_process(delta):
	var input_dir = 0

	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1

	velocity.x = input_dir * SPEED

	if input_dir != 0:
		if not pasos.playing:
			pasos.play()
	else:
		if pasos.playing:
			pasos.stop()

	# TODO: Use proper jump dynamics
	if Input.is_action_just_pressed("ui_up") and velocity.y == 0:
		velocity.y = JUMP_FORCE
	
	velocity.y += GRAVITY * delta

	if anim:
		if input_dir != 0:
			anim.animation = "Correr"
			anim.flip_h = input_dir < 0
		else:
			anim.animation = "Parado"

	move_and_slide()

func add_flame():
	flames_num += 1
	update_ui()
	
func update_ui():
	if flames_num:
		#flames_num.text = str(flames_num)
		flames_num.text = 999

func _on_Area2D_area_entered(area):
	if area.is_in_group("flame"):
		print("Has recollit la flama")
