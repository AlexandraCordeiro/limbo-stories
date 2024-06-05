extends Area2D

class_name forest_entry

func _on_body_entered(body):
	if body is Player:
		global.what_scene = global.level_sw_dir
		global.position_find_diary.erase("player")
		global.enteredLevel = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://level_switcher.tscn")
