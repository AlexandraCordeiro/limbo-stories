extends Area2D

var entered = false
var scene_changed = false

func _on_body_entered(body):
	if body is Player:
		entered = true
		# print("entered\n")

func _on_body_exited(body):
	if body is Player:
		entered = false
		global.diary_was_found = true
		# print("exited\n")

func _process(_delta):
	if global.read_mode:
		self.visible = false
	if entered and !scene_changed and !global.diary_was_found:
		# Save the player position before changing the scene
		global.position_find_diary["player"] = position
		# Delay the scene change by one frame to ensure the position is saved
		call_deferred("_change_scene")

func _change_scene():
	scene_changed = true
	global.read_mode = true
	get_tree().change_scene_to_file("res://second_entry.tscn")