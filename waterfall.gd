extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$w1.play()
	$w3.play()
	$w4.play()
	$w5.play()
	$w2.play()
	$waterfall.play()
	global.waterfall = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
