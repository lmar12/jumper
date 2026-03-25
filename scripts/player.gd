extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal score_changed(v)
const JUMP_FORCE : int = 410
var player_speed: int = 1
enum STATE {MOVE, JUMP}
var current_state : STATE = STATE.MOVE
var started: bool = false
var paused: bool = false
var score: float = 0
signal touched()
func _ready() -> void:
	animation_player.play("appear_anim")
func update_score(v:float)->void:
	score += v 
	emit_signal("score_changed", floor(score))
	#feo, pero funciona
	GlobalScript.update_global_score(floor(score))
func update_speed()->void:
	animated_sprite_2d.speed_scale = GlobalScript.game_speed_multiplier
func _process(delta: float) -> void:
	update_state()
	if(started and not paused):
		update_score(delta*5)
	#print(floor(score))
func change_state(new_state: STATE)->void:
	match current_state:
		STATE.MOVE:
			match new_state:
				STATE.JUMP:
					animation_player.play("jump")
					animated_sprite_2d.play("jump")
		STATE.JUMP:
			match new_state:
				STATE.MOVE:
					animation_player.play("RESET")
					animated_sprite_2d.play("move")
	#Change the state
	current_state = new_state
func update_state()->void:
	match current_state:
		STATE.MOVE:
			handle_input()
			if(not is_on_floor()):
				change_state(STATE.JUMP)
		STATE.JUMP:
			if(is_on_floor()):
				change_state(STATE.MOVE)
func handle_input()->void:
	if(Input.is_action_just_pressed("jump_player") and is_on_floor()):
		velocity.y += -JUMP_FORCE
func _physics_process(delta: float) -> void:
	if(not is_on_floor()):
		velocity.y += get_gravity().y * delta
	move_and_slide()
func pause()->void:
	paused = !paused
	set_process(!paused)
	set_physics_process(!paused)
func start()->void:
	started = true	


func _on_main_scene_level_up() -> void:
	animated_sprite_2d.speed_scale = animation_player.speed_scale * GlobalScript.get_game_speed_multiplier()
func _on_game_over()->void:
	collision_shape_2d.set_disabled(true)
	set_process(false)
	set_physics_process(false)
	animated_sprite_2d.pause()
	animation_player.play("game_over_anim")
	
