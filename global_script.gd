extends Node

var diary_was_found = false
var fist_time_scene_principal = true
var read_mode = false
var cover = preload("res://cover.tscn").instantiate()
var waterfall = preload("res://waterfall.tscn").instantiate()
var first_entry = preload("res://first_entry.tscn").instantiate()
var second_entry = preload("res://second_entry.tscn").instantiate()
var poem = preload("res://poem.tscn").instantiate()

var cover_dir = "res://cover.tscn"
var waterfall_dir = "res://waterfall.tscn"
var first_entry_dir = "res://first_entry.tscn"
var second_entry_dir = "res://second_entry.tscn"
var poem_dir = "res://poem.tscn"
var scene_dir = "res://scene.tscn"

var diary_entries = {"cover": cover_dir, "first_entry": first_entry_dir, "second_entry": second_entry_dir}
var position_find_diary = {}
var memory_challenge = [-1, -1]
var level_number = 0


func diary_found(player_position):
	# Update position_find_diary with the position where the diary was found
	position_find_diary["player"] = player_position
	print(position_find_diary["player"])
