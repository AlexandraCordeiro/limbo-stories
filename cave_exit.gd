extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		global.what_scene = global.waterfall_dir
		global.waterfallLevel = true
		global.position_find_diary.erase("player")
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		print("if entered -> cave_exit.gd")
		get_tree().change_scene_to_file("res://waterfall.tscn")
