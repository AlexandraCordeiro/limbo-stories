extends Area2D
const POEM_WIDTH = 450
const POEM_HEIGHT = 450

func _on_body_entered(body):
	if body is Player:
		global.enteredLevel = true
		global.diary_entries["poem_entry"] = global.poem_entry_dir
		print(global.diary_entries["poem_entry"])
		"""
		var poem = global.poem
		var player_position = body.global_position
		var centered_position = player_position - Vector2(POEM_WIDTH / 2, POEM_HEIGHT / 2)
		poem.global_position = centered_position
		"""
		# get_tree().root.add_child(poem)
		get_tree().change_scene_to_file(global.poem_entry_dir)
