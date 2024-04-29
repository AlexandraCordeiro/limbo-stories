extends Node2D

@onready var current = $Level
var level_number = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_level_changed(level_type, load_zone, correct_zone):
	if correct_zone == load_zone:
		print("yuppi")
		
	var new_scene = load("res://forest_base.tscn").instantiate()
	call_deferred("add_child", new_scene)
	new_scene.connect("level_changed", _on_level_level_changed)
	current.queue_free()
	current = new_scene
	
	
	
