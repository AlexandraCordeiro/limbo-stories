extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.read_mode_diary:
		self.visible = true
	else:
		self.visible = false



func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:    # button left == 1
		var current_page = get_tree().current_scene.name
		print("Current Page:", current_page)
		var keys = global.diary_entries.keys()
		print("Keys:", keys)
		for i in range(keys.size()):
			var key = keys[i]
			print("Key:", key)
			if key == current_page and i > 0:  # Check if there is a previous page
				print("*****")
				var previous_page = global.diary_entries[keys[i - 1]]
				print("Previous Page:", previous_page)
				if previous_page:
					get_tree().change_scene_to_file(previous_page)
				else:
					print("Previous page is not defined.")
