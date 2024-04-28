extends Node2D
var entered = false
signal load_zone_entered(load_zone)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		print("okay")
		load_zone_entered.emit("1");
		entered = false
	pass


func _on_loader_body_entered(body):
	print("hm")
	entered = true


func _on_loader_body_exited(body):
	entered = false
