extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 1000

@onready var anim = $AnimatedSprite2D
@onready var pasos = $pasos_audio
@onready var counter_label = get_tree().get_first_node_in_group("ui_counter")

var llamas = 0

func _ready():
	add_to_group("player")  # This allows collectibles to recognize this as the player

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

	move_and_slide()

func add_collectible():
	llamas += 1
	print("I got it!")
	update_ui()
	
func update_ui():
	if counter_label:
		counter_label.text = str(llamas)
	print("Collectibles: ", llamas)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Llama"):
		print("collected flame")
