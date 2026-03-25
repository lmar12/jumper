extends Parallax2D
func _process(delta: float) -> void:
	autoscroll.x = GlobalScript.game_speed_multiplier * -1.0
