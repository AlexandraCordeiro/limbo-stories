extends CharacterBody2D
class_name Player

const speed = 300
var current_dir = "down"

var is_chatting = false

enum PlayerState {
	IDLE,
	MOVING,
	DIALOGUE
}

var state = PlayerState.DIALOGUE

@onready var camera = $Camera2D

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)

func _process(delta):
	match state:
		PlayerState.IDLE:
			if not is_chatting:
				player_movement(delta)
		PlayerState.DIALOGUE:
			if not is_chatting:
				run_dialogue("startGame")
		PlayerState.MOVING:
			player_movement(delta)



func player_movement(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		state = PlayerState.IDLE
	elif direction.x != 0 or direction.y != 0:
		state = PlayerState.MOVING
	
	velocity = direction * speed
	move_and_slide()
	play_anim(direction)
	
func play_anim(dir):
	if state == PlayerState.IDLE:
		$AnimatedSprite2D.play("idle")
	if state == PlayerState.MOVING:
		if dir.y == -1:
			$AnimatedSprite2D.play("n-walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e-walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s-walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w-walk")
			
func player():
	pass

func run_dialogue(dialogue_string):
	is_chatting = true
	state = PlayerState.DIALOGUE
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "end":
		print("dialogue start ended")
		is_chatting = false
		state = PlayerState.IDLE

	

