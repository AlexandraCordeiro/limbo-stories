extends Node2D


@onready var tilemap = $TileMap;

var level_type : int = 0;
var correct_zone : int = 0;
var last_type : int = -1;
var rng = RandomNumberGenerator.new()


signal level_changed(level_type, load_zone, correct_zone);

# Called when the node enters the scene tree for the first time.
func _ready():
	correct_zone = rng.randi_range(0, 2)
	var aux = 0;
	
	while last_type != aux:
		aux = rng.randi_range(0, 2)
		
	last_type = level_type;
	level_type = aux;
	tilemap.set_cell(3, Vector2i(100, 100), 5, Vector2i(1, 5), 0)
	
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_loading_zone_load_zone_entered(load_zone):
	#logic if correct loading zone
	
	level_changed.emit(level_type, load_zone, correct_zone);
	return
