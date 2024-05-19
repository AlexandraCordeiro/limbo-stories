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
		var player = get_parent().get_parent()
		global.diary_found(player.position)
		get_tree().change_scene_to_file(global.cover_dir)
