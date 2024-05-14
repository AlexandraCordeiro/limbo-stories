extends Node

var diary_was_found = false
var fist_time_scene_principal = true
var read_mode = false
var cover = preload("res://cover.tscn").instantiate()
var waterfall = preload("res://waterfall.tscn").instantiate()
var first_entry = preload("res://poem.tscn").instantiate()
var second_entry = preload("res://second_entry.tscn").instantiate()
var diary_entries = {"cover": cover, "first_entry": first_entry}
var position_find_diary = {}
var memory_challenge = [-1, -1]
var level_number = 0


func diary_found(player_position):
	# Update position_find_diary with the position where the diary was found
	position_find_diary["player"] = player_position
	print(position_find_diary["player"])
