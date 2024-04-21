extends Area2D

var entered = false
var scene_changed = false
var diary_scene

func _init():
	diary_scene = preload("res://OpenedDiary.tscn").instantiate()
func _on_body_entered(body):
	if body is Player:
		entered = true
		# print("entered\n")


func _on_body_exited(body):
	if body is Player:
		entered = false
		global.diaryWasFound = true
		# print("exited\n")

func _process(_delta):
	if entered and !scene_changed:
		get_tree().root.add_child(diary_scene)
		scene_changed = true
		
