extends Node
class_name GLOBAL
const VIEWPORT_SIZE : Vector2i = Vector2i(448,256)
var best_score:int = 0
var game_speed_multiplier:float = 1
var score := 0
func change_game_speed_multiplier(v:float)->void:
	game_speed_multiplier = v
func get_game_speed_multiplier()->float:
	return game_speed_multiplier
func update_global_score(v:int)->void:
	score = v
func set_best_score(v:int)->void:
	best_score = v
