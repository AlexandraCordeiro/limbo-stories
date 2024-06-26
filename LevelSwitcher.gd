extends Node2D

@onready var current = $Level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_level_changed(level_type, load_zone, correct_zone):
	if correct_zone == load_zone:
		print(global.level_number + 1)
		global.level_number += 1
		var new_scene
		
		if global.level_number > 7:
			global.enteredLevel = false
			global.waterfallLevel = true
			global.what_scene = global.waterfall_dir
			new_scene = load("res://waterfall.tscn").instantiate()
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			
		else:
			new_scene = load("res://forest_base.tscn").instantiate()
		call_deferred("add_child", new_scene)
		new_scene.connect("level_changed", _on_level_level_changed)
		current.queue_free()
		current = new_scene
		
	else:
		global.memory_challenge = [-1, -1]
		global.level_number = 0
		
		var new_scene = load("res://forest_base.tscn").instantiate() #TODO: scene before this one
		call_deferred("add_child", new_scene)
		new_scene.connect("level_changed", _on_level_level_changed)
		current.queue_free()
		current = new_scene
	
	
