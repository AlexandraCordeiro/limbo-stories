extends Area2D

var entered = false
var collision_shape
var scene_changed = false

func _ready():
	collision_shape = get_node("CollisionShape2D")

func _on_body_entered(body):
	if body is Player:
		entered = true
		global.diary_entries["poem_entry"] = global.poem_entry_dir
		global.read_mode_poem = true
		print("body entered on poem")
		#global.enteredLevel = true
		global.diary_found(body.position)

func _on_body_exited(body):
	if body is Player:
		entered = false
		global.poem_was_found = true
		global.open_tunel()

func _process(_delta):
	if global.read_mode_poem:
		call_deferred("set_visibility", false)
	if entered and !scene_changed and !global.poem_was_found:
		print("changing poem scene")
		scene_changed = true
		_change_scene()

func _change_scene():
	global.open_tunel()
	print("Poem: Changing scene, setting visibility to false")
	call_deferred("set_visibility", false)
	get_tree().change_scene_to_file(global.poem_entry_dir)

func set_visibility(visible):
	if visible:
		self.show()
	else:
		self.hide()
