extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(animation_name):
	if animation_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif animation_name == "fade_to_normal":
		color_rect.visible = false

func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")
