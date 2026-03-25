extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var x_limit: int = -15
const BASE_SPEED = 60
enum ENT_STATE {RUNNING, PAUSED}
const DEFAULT_TRAIL : int = -450
var paused: bool = false
var current_ent_state : ENT_STATE = ENT_STATE.RUNNING
var move_velocity:= 1
func _ready() -> void:
	animated_sprite_2d.speed_scale = animated_sprite_2d.speed_scale*GlobalScript.get_game_speed_multiplier()/2
func move(delta: float)->void:
	position.x +=  -move_velocity * delta
func set_move_velocity(v:float, randomize_scale: float)->void:
	move_velocity = v + ((v*randomize_scale)* randf())*(-1**(randi_range(1,2)))
func get_base_speed()->int:
	return BASE_SPEED
func _process(delta: float) -> void:
	move(delta)
	if(to_global(position).x < DEFAULT_TRAIL):
		remove()
func _on_body_entered(body: Node2D) -> void:
	body.emit_signal("touched")
func pause()->void:
	paused = !paused
	set_process(!paused)
func remove()->void:
	queue_free()
