extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	global.read_mode_diary = false
	print(global.diary_entries)
	$w1.play()
	$w3.play()
	$w4.play()
	$w5.play()
	$w2.play()
	$waterfall.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
