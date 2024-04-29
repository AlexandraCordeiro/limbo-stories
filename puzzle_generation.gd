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

var level_type : int = 0;
var correct_zone : int = 0;
var last_type : int = -1;
var rng = RandomNumberGenerator.new()
var random = [0, 1, 2]

const indices = {0: "left", 1: "right", 2: "top"};
const LEFT_AUDIO_POS = Vector2(30, 62)
const RIGHT_AUDIO_POS = Vector2(30, 62)
const TOP_AUDIO_POS = Vector2(30, 62)
const AUDIO_POS_ARRAY = [Vector2(30, 62), 
const FLOWERBED_POS_ARRAY = [Vector2i(11, 9), Vector2i(21, 9), Vector2i(16, 5)]
const LEFT_FLOWERBED_POS = Vector2i(11, 9)
const RIGHT_FLOWERBED_POS = Vector2i(21, 9)
const TOP_FLOWERBED_POS = Vector2i(16, 5)




signal level_changed(level_type, load_zone, correct_zone);

# Called when the node enters the scene tree for the first time.
func _ready():
	
	random.shuffle()
	correct_zone = random[0]
	
	var aux = 0;
	
	while last_type == aux:
		aux = rng.randi_range(0, 2)
		
	last_type = level_type;
	level_type = aux;
	print("oi!")
	
	# branches_audio_1.play()
	
	#gen_flowerbed_puzzle()
	
	return


func gen_flowerbed_puzzle():
	var color = rng.randi_range(0, 1)
	correct_zone += color
	var flowerbed_id = 15 + color
	
	tilemap.set_cell(3, FLOWERBED_POS_ARRAY[random[color]], flowerbed_id, Vector2i(0, 0))
	tilemap.set_cell(3, FLOWERBED_POS_ARRAY[random[color + 1]], flowerbed_id - 2, Vector2i(0, 0))
	tilemap.set_cell(3, FLOWERBED_POS_ARRAY[random[(color + 2) % 3]], flowerbed_id - 4, Vector2i(0, 0))
	
	tilemap.set_layer_enabled(3, true)
	
	print("siga")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_loading_zone_load_zone_entered(load_zone):
	#logic if correct loading zone
	
	#level_changed.emit(level_type, 0, correct_zone);
	#return


#func _on_loading_zone_1_load_zone_entered(load_zone):
	#level_changed.emit(level_type, 1, correct_zone);
	#return


#func _on_loading_zone_2_load_zone_entered(load_zone):
	#level_changed.emit(level_type, 2, correct_zone);
	#return


func _on_left_zone_load_zone_entered():
	level_changed.emit(level_type, 0, correct_zone)


func _on_top_zone_load_zone_entered():
	level_changed.emit(level_type, 1, correct_zone)


func _on_right_zone_load_zone_entered():
	level_changed.emit(level_type, 2, correct_zone)
