extends Node2D


@onready var tilemap = $TileMap;
@onready var birdy1 = $Bird1;
@onready var birdy2 = $Bird2;
@onready var birdy3 = $Bird3;
@onready var bird_audio = $BirdAudio;
@onready var branches_audio_1 = $BranchesAudio1;
@onready var branches_audio_2 = $BranchesAudio2;
@onready var bushes_audio_1 = $BushesAudio1;
@onready var bushes_audio_2 = $BushesAudio2;
@onready var star_1 = $StarAnimator;
@onready var star_2 = $StarAnimator2;


var level_type : int = 0;
var correct_zone : int = 0;
var last_type : int = -1;
var rng = RandomNumberGenerator.new()
var random = [0, 1, 2]

const indices = {0: "left", 1: "right", 2: "top"};
const LEFT_AUDIO_POS = Vector2(30, 62)
const RIGHT_AUDIO_POS = Vector2(30, 62)
const TOP_AUDIO_POS = Vector2(30, 62)
const AUDIO_POS_ARRAY = [Vector2(30, 42), Vector2(235, 42), Vector2(140, 20)]
const FLOWERBED_POS_ARRAY = [Vector2i(11, 9), Vector2i(21, 9), Vector2i(16, 5)]
const LOADZONES_POS_ARRAY = [Vector2i(0, 7), Vector2i(32, 7), Vector2i(16, -1)]
const LEFT_FLOWERBED_POS = Vector2i(11, 9)
const RIGHT_FLOWERBED_POS = Vector2i(21, 9)
const TOP_FLOWERBED_POS = Vector2i(16, 5)

signal level_changed(level_type, load_zone, correct_zone);
signal set_memory_challenge(star_type, correct_zone);

# Called when the node enters the scene tree for the first time.
func _ready():
	global.enteredLevel = true
	random.shuffle()
	correct_zone = random[0]
	
	var aux = 0;
	
	while last_type == aux:
		aux = rng.randi_range(0, 2)
		
	last_type = level_type;
	level_type = aux;
	print("oi!")
	
	var level_number = global.level_number
	
	match level_number:
		0:
			gen_memory_puzzle()
		1:
			gen_flowerbed_puzzle()
		2:
			gen_memory_puzzle()
		3:
			gen_memory_puzzle()
		4:
			gen_flowerbed_puzzle()
		5:
			gen_memory_puzzle()
		6:
			gen_audio_puzzle()
		7:
			gen_final_puzzle()
		
	
	# branches_audio_1.play()
	
	#gen_flowerbed_puzzle()
	
	return

func gen_final_puzzle():
	correct_zone = 2
	tilemap.set_layer_enabled(6, true)
	birdy1.visible = true
	birdy2.visible = true
	birdy3.visible = true
	
func gen_audio_puzzle():
	
	bird_audio.position = AUDIO_POS_ARRAY[correct_zone]
	bird_audio.play()
	branches_audio_1.position = AUDIO_POS_ARRAY[random[1]]
	branches_audio_1.play()
	bushes_audio_1.position = AUDIO_POS_ARRAY[random[1]]
	bushes_audio_1.play()
	branches_audio_2.position = AUDIO_POS_ARRAY[random[2]]
	branches_audio_2.play()
	bushes_audio_2.position = AUDIO_POS_ARRAY[random[2]]
	bushes_audio_2.play()
	
	tilemap.set_layer_enabled(5, true)
	
	
func gen_memory_puzzle():
	var star_type = rng.randi_range(0, 1)
	
	if global.memory_challenge[star_type] == -2:
		star_type = (star_type + 1) % 2
		
	if global.memory_challenge[star_type] == -1:
		global.memory_challenge[star_type] = correct_zone
		
		for i in range(3):
			if i == correct_zone:
				continue
			tilemap.set_cell(1, LOADZONES_POS_ARRAY[i], 5, Vector2i(1, 5))
	else:
		correct_zone = global.memory_challenge[star_type]
		global.memory_challenge[star_type] = -2
		
		for i in range(3):
			tilemap.set_cell(1, LOADZONES_POS_ARRAY[i], -1)
		
	match star_type:
		0:
			star_1.visible = true
		1:
			star_2.visible = true
	
	tilemap.set_layer_enabled(4, true)

func gen_flowerbed_puzzle():
	var color = rng.randi_range(0, 1)
	correct_zone = random[1 - color]
	var flowerbed_id = 15 + color
	
	tilemap.set_cell(3, FLOWERBED_POS_ARRAY[random[0]], flowerbed_id, Vector2i(1, 2))
	tilemap.set_cell(3, FLOWERBED_POS_ARRAY[random[1]], flowerbed_id - 2, Vector2i(1, 2))
	tilemap.set_cell(3, FLOWERBED_POS_ARRAY[random[2]], flowerbed_id - 4, Vector2i(1, 2))
	
	tilemap.set_layer_enabled(3, true)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_left_zone_load_zone_entered():
	level_changed.emit(level_type, 0, correct_zone)


func _on_top_zone_load_zone_entered():
	level_changed.emit(level_type, 2, correct_zone)


func _on_right_zone_load_zone_entered():
	level_changed.emit(level_type, 1, correct_zone)
