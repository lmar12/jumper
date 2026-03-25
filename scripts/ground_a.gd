extends Parallax2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func appear_anim()->void:
	animation_player.play("scale_fast")
func _ready() -> void:
	appear_anim()
func _process(delta: float) -> void:
	autoscroll.x = -25.0 * GlobalScript.get_game_speed_multiplier()*1.2
func dissapear_anim()->void:
	animation_player.play("dissapear_anim")
