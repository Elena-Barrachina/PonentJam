extends RigidBody2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		var bg_manager = get_tree().get_first_node_in_group("background_manager")
		if bg_manager:
			bg_manager.ripple_to_warm(global_position)
		queue_free()  # remove object after interaction
