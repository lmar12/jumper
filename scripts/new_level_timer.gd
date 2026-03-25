extends Timer
@export var default_time : = 10.0
var timer_left : = 0.0
func _ready() -> void:
	start(default_time)
func pause()->void:
	if(not paused):
		timer_left = time_left
		stop()
	else:
		start(timer_left) 
func _on_timeout() -> void:
	start(default_time)
