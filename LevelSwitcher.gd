extends Node2D

@onready var current = $Level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_level_changed(level_type):
	print(level_type);
	var new_scene = load("res://forest_base.tscn").instantiate()
	call_deferred("add_child", new_scene)
	new_scene.connect("level_changed", _on_level_level_changed)
	current.queue_free()
	current = new_scene
	
	
	
