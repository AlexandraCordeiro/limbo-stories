extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	
	if global.diaryWasFound:
		self.visible = true
		if event is InputEventMouseButton and event.pressed and event.button_index == 1:	# button left == 1
			pass
	else:
		self.visible = false
		
			
