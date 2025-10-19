extends Node2D

@onready var cold_bg = $ColdBackground
@onready var warm_bg = $WarmBackground

func _ready():
	cold_bg.visible = true
	warm_bg.visible = true
	# Assign shader material
	var mat = ShaderMaterial.new()
	mat.shader = preload("res://shaders/RippleFade.gdshader")
	warm_bg.material = mat
	#warm_bg.set_shader_param("ripple_radius", 0.0)

func ripple_to_warm(world_pos: Vector2):
	# Convert world position to UV
	var local_pos = warm_bg.to_local(world_pos)
	var uv = local_pos / warm_bg.texture.get_size()
	warm_bg.set_shader_param("ripple_center", uv)
	warm_bg.set_shader_param("ripple_radius", 0.0)

	# Animate the ripple expanding and fading cold background
	var tween = create_tween()
	tween.tween_property(warm_bg.material, "shader_param/ripple_radius", 1.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(cold_bg, "modulate:a", 0.0, 0.6) # fade out cold_bg
