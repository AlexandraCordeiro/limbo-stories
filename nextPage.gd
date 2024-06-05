extends Area2D
var hasNextPage
var hasPreviousPage
var current_page
# Called when the node enters the scene tree for the first time.
func _ready():
	current_page = get_tree().current_scene.name
	hasNextPage = checkNextPage()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hasNextPage = checkNextPage()
	if global.read_mode_diary && hasNextPage:
		self.visible = true
	else:
		self.visible = false

func checkNextPage():
	var current_page = get_tree().current_scene.name
	print(current_page)
	var keys = global.diary_entries.keys()
	print(keys)
	for i in range(keys.size()):
		var key = keys[i]
		if key == current_page && i == keys.size() - 1:
			# nao ha mais paginas a seguir
			return false
	return true
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:    # button left == 1
		var current_page = get_tree().current_scene.name
		print("Current Page:", current_page)
		var keys = global.diary_entries.keys()
		print("Keys:", keys)
		for i in range(keys.size()):
			var key = keys[i]
			print("Key:", key)
			if key == current_page and i < keys.size() - 1:
				print("*****")
				var next_page = global.diary_entries[keys[i + 1]]
				print("Next Page:", next_page)
				if next_page:
					get_tree().change_scene_to_file(next_page)
					# get_tree().root.add_child(next_page)
				else:
					print("Next page is not defined.")
