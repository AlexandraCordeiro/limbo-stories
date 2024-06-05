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
var request_dialogue = false

@onready var camera = $Camera2DPlayer

signal changeWaterfallScene()

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	print(global.position_find_diary)
	if global.enteredLevel:
		if global.position_find_diary.has("player"):
			position = global.position_find_diary["player"]
		else:
			position = Vector2(131.75, 112)
		return
	if global.waterfallLevel:
		if global.position_find_diary.has("player"):
			position = global.position_find_diary["player"]
		else:
			position = Vector2(25.25, 62.75)
		return
	if global.enteredCave > 0 and global.waterfallLevel == false:
		if global.position_find_diary.has("player"):
			position = global.position_find_diary["player"]
		else:
			position = Vector2(114, 145)
		return		
	if global.position_find_diary.has("player") and global.positionFirstScene:
		# Set the player position to the position stored in global.position_find_diary
		print("Update position diary/inventory")
		position = global.position_find_diary["player"]
		global.positionFirstScene = false
		return
	else:
		print("error position diary/inventory")

func _process(delta):
	if global.diary_was_found and global.fist_time_scene_principal:
		#global.diary_found(position)
		global.fist_time_scene_principal = false
		state = PlayerState.DIALOGUE
		
	if global.diary_was_found and not request_dialogue:
		state = PlayerState.MOVING
		
	match state:
		PlayerState.DIALOGUE:
			print("is_chatting:")
			print(is_chatting)
			if not is_chatting and global.enteredCave == 1:
				run_dialogue("waterfall")
			elif not is_chatting and !global.diary_was_found:
				run_dialogue("startGame")
				
		PlayerState.IDLE:
			if not is_chatting:
				player_movement(delta)
			
		PlayerState.MOVING:
			player_movement(delta)
	
func player_movement(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		if state != PlayerState.DIALOGUE:
			state = PlayerState.IDLE
	elif direction.x != 0 or direction.y != 0:
		if state != PlayerState.DIALOGUE:
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
	
func _input(event):
	if event.is_action_pressed("poem") and global.enteredLevel:
		state = PlayerState.DIALOGUE
		print("bruh")
		$Camera2DPlayer/Poem.visible = !$Camera2DPlayer/Poem.visible
		
	if event.is_action_released("poem") and global.enteredLevel:
		state = PlayerState.IDLE
		$Camera2DPlayer/Poem.visible = !$Camera2DPlayer/Poem.visible
		
	if event.is_action_pressed("diary") and state != PlayerState.DIALOGUE and global.diary_was_found and !global.enteredLevel:
		global.diary_found(self.position)
		get_tree().change_scene_to_file(global.cover_dir)
		

func DialogicSignal(arg: String):
	is_chatting = false
	request_dialogue = false
	if arg == "end":
		state = PlayerState.IDLE
		print("dialogue start ended")
	elif arg == "endWaterfall":
		print("waterfall dialogue ended")
		changeWaterfallScene.emit()


func _on_waterfall_collision_box_dialogue_waterfall():
	print("dentro do main_character signal receiver, global.enteredCave:")
	print(global.enteredCave)
	if global.enteredCave == 1:
		state = PlayerState.DIALOGUE
		request_dialogue = true
	else:
		changeWaterfallScene.emit()
