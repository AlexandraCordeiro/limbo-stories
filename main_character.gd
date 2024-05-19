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

@onready var camera = $Camera2DPlayer

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	if global.position_find_diary.has("player"):
		# Set the player position to the position stored in global.position_find_diary
		position = global.position_find_diary["player"]

func _process(delta):
	if global.diary_was_found and global.fist_time_scene_principal:
		global.diary_found(position)
		global.fist_time_scene_principal = false
		state = PlayerState.DIALOGUE
		
	if global.diary_was_found:
		state = PlayerState.MOVING
		
	match state:
		PlayerState.IDLE:
			if not is_chatting:
				player_movement(delta)
		PlayerState.DIALOGUE:
			if not is_chatting and !global.diary_was_found:
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
		$AnimatedSprite2D.play("idle_boy")
	if state == PlayerState.MOVING:
		if dir.y == -1:
			$AnimatedSprite2D.play("run_up")
		if dir.x == 1:
			$AnimatedSprite2D.play("run_right")
		if dir.y == 1:
			$AnimatedSprite2D.play("run_down")
		if dir.x == -1:
			$AnimatedSprite2D.play("run_left")
			
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
