extends CanvasLayer

@onready var flames_num = get_tree().get_first_node_in_group("flames_num")

func pop_flame_effect():
	var labels = get_tree().get_nodes_in_group("flames_num")
	print(labels)
	for lbl in labels:
		if lbl is Label:
			var tween = create_tween()
			tween.set_parallel(true)
			
			# Scale up & fade to orange
			tween.tween_property(lbl, "scale", Vector2(1.5, 1.5), 0.15)
			tween.tween_property(lbl, "modulate", Color(1, 0.5, 0), 0.15)
			tween.tween_property(flames_num, "position:x", flames_num.position.x + 10, 0.15)
			tween.tween_property(flames_num, "position:y", flames_num.position.y + -10, 0.15)

			# Return to normal
			tween.chain().tween_property(lbl, "scale", Vector2.ONE, 0.4)
			tween.tween_property(lbl, "modulate", Color.WHITE, 0.4)
			tween.tween_property(flames_num, "position:x", flames_num.position.x, 0.4)
			tween.tween_property(flames_num, "position:y", flames_num.position.y, 0.4)
			
