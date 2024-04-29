extends Node2D

var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	entered = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player and entered == false:
		entered = true
		$Star.play("default")
