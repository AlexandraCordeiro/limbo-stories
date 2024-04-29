extends Node2D
var entered = false
signal load_zone_entered


# Called when the node enters the scene tree for the first time.
func _ready():
	entered = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		print("okay")
		load_zone_entered.emit();
		entered = false
	pass


func _on_loader_body_entered(body):
	if body is Player:
		print("hm")
		entered = true


func _on_loader_body_exited(body):
	entered = false
