extends Area2D


func _on_body_entered(body):
	if body is Player:
		global.enteredLevel = true
		get_tree().change_scene_to_file(global.poem_dir)
