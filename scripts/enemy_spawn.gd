extends Node2D
const Enemies := [
	preload("res://scenes/enemy_a.tscn"),
	preload("res://scenes/enemy_b.tscn"),
	preload("res://scenes/enemy_c.tscn")	
]
var default_enemy_timer := 4
var current_enemy_timer := 4
var timer_left: = 0.0
var paused: = false
@onready var timer: Timer = $Timer
func start()->void:
	timer.start()
func stop()->void:
	timer.stop()
func pause()->void:
	if(not paused):
		timer_left = timer.time_left
		timer.stop()
		paused = true
	else:
		timer.start(timer_left)
		paused = false
	for i in range(get_child_count()):
		var c := get_child(i)
		if(c.is_in_group("Pausable")):
			c.pause()
func _ready() -> void:
	pass
func get_local_position()->Vector2:
	return to_local(position)
func create_new_enemy()->void:
	var new_enemy = Enemies.pick_random().instantiate()
	new_enemy.position = get_local_position()
	new_enemy.set_move_velocity(new_enemy.get_base_speed() * GlobalScript.get_game_speed_multiplier(), 0.02)
	add_child(new_enemy)
func randomize_timer()->void:
	#timer.wait_time = (default_enemy_timer - GlobalScript.get_game_speed_multiplier()) + randf_range(0.0,0.7)
	#print((default_enemy_timer/(GlobalScript.get_game_speed_multiplier()*1.5)))
	current_enemy_timer = (default_enemy_timer/(GlobalScript.get_game_speed_multiplier())) - randf_range(0.0,0.7)
func _on_timer_timeout() -> void:
	create_new_enemy()
	randomize_timer()
	timer.start(current_enemy_timer)
