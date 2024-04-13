extends Area2D

var entered = false

func _on_body_entered(body):
	if body is Player:
		entered = true
		# print("entered\n")


func _on_body_exited(body):
	if body is Player:
		entered = false
		# print("exited\n")

func _process(_delta):
	if entered == true:
		# print("new scene\n")
		get_tree().change_scene_to_file("res://OpenedDiary.tscn")
		
			
