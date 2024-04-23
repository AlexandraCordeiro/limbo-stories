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
	if entered and !scene_changed:
		get_tree().root.add_child(global.first_entry)
		scene_changed = true
		global.read_mode = true
		
