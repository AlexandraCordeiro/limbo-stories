extends Node

var diary_was_found = false
var read_mode = false
var cover = preload("res://cover.tscn").instantiate()
var first_entry = preload("res://first_entry.tscn").instantiate()
var second_entry = preload("res://second_entry.tscn").instantiate()
var diary_entries = {"cover": cover, "first_entry": first_entry}
