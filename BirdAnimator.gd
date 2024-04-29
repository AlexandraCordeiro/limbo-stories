extends Node2D

@onready var birdy = $Bird

var entered 
# Called when the node enters the scene tree for the first time.
func _ready():
	birdy.play("default")
	entered = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		birdy.position += Vector2(0, -1)



func _on_area_2d_body_entered(body):
	if body is Player:
		entered = true
		birdy.play("fly_away")
