extends Area2D

var entered = false
var scene_changed = false
var collision_shape

func _ready():
	collision_shape = get_node("CollisionShape2D")
	
func _on_body_entered(body):
	if body is Player:
		entered = true
		global.read_mode_diary = true
		global.diary_found(body.position)

func _on_body_exited(body):
	if body is Player:
		entered = false
		global.diary_was_found = true
		global.open_tunel()

func _process(_delta):
	if global.read_mode_diary:
		call_deferred("set_visibility", false)
	if entered and !scene_changed and !global.diary_was_found:
		scene_changed = true
		_change_scene()

func _change_scene():
	print("Diary: Changing scene, setting visibility to false")
	get_tree().change_scene_to_file(global.first_entry_dir)

func set_visibility(visible):
	if visible:
		self.show()
	else:
		self.hide()
