extends Node
enum STATE {INIT, PLAYING, PAUSE, GAME_OVER}
var current_state : STATE = STATE.INIT
var current_level : int = 1
signal level_up()
signal end_game()
const GAME_OVER_MESSAGE = preload("uid://3hhvwxxbvggi")

@onready var ui: Control = $UI
@onready var enemy_spawn: Node2D = $EnemySpawn
@onready var player: CharacterBody2D = $Player
@onready var new_level: Timer = $NewLevel
@onready var end_timer: Timer = $EndTimer

func update_state()->void:
	match current_state:
		STATE.PLAYING:
			if(pause_nodes()):
				change_state(STATE.PAUSE)
		STATE.PAUSE:
			if(pause_nodes()):
				change_state(STATE.PLAYING)
		STATE.GAME_OVER:
			pass
func change_state(n: STATE)->void:
	match current_state:
		STATE.PLAYING:
			match n:
				STATE.GAME_OVER:
					enemy_spawn.stop()
					new_level.stop()
					emit_signal("end_game")
					GlobalScript.set_best_score(GlobalScript.score)
					var gm : = GAME_OVER_MESSAGE.instantiate()
					gm.set_values(str(GlobalScript.score), str(current_level))
					add_child(gm)
					end_timer.start()
			pass
		STATE.PAUSE:
			pass
		STATE.GAME_OVER:
			pass
		STATE.INIT:
			#init score to 0
			GlobalScript.update_global_score(0)
			enemy_spawn.start()
			player.start()
			new_level.start()
	current_state = n
func _process(delta: float) -> void:
	update_state()
func pause_nodes()->bool:
	if(Input.is_action_just_pressed("pause_game")):
		stop_nodes()
		return true
	return false
func stop_nodes()->void:
	var childs := get_child_count()
	for i in range(childs):
		var c := get_child(i)
		if(c.is_in_group("Pausable")):
			c.pause()


func _on_new_level_timeout() -> void:
	GlobalScript.change_game_speed_multiplier(
		GlobalScript.get_game_speed_multiplier()+0.4
	)
	current_level += 1
	ui.update_level(current_level)
	emit_signal("level_up")


func _on_init_time_timeout() -> void:
	change_state(STATE.PLAYING)


func _on_player_game_over() -> void:
	print("game_over")
	change_state(STATE.GAME_OVER)

func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file(" ")
