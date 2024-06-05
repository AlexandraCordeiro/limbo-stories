extends Area2D

var entered

signal dialogueWaterfall()

# Called when the node enters the scene tree for the first time.
func _ready():
	entered = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		global.enteredCave += 1
		print("global.enteredCave:")
		print(global.enteredCave)
		dialogueWaterfall.emit()


func _on_character_body_2d_change_waterfall_scene():
	global.what_scene = global.cave_dir
	global.waterfallLevel = false
	global.position_find_diary.erase("player")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://cave.tscn")
