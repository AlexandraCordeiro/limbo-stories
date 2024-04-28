extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.read_mode:
		self.visible = true
	else:
		self.visible = false


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:	# button left == 1
		var current_page = get_tree().current_scene.name
		print(current_page)
		var keys = global.diary_entries.keys()
		print(keys)
		for i in range(keys.size()):
			var key = keys[i]
			print(key)
			if key == current_page and i < keys.size() - 1:
				get_tree().root.add_child(global.diary_entries[i + 1])
		
