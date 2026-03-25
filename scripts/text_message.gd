extends Label
var tween : Tween = null
@onready var timer: Timer = $Timer
@onready var freeze_timer: Timer = $FreezeTime

@export var freeze_time := 0.2
@export var time:int = 4
# Called when the node enters the scene tree for the first time.
func init_message()->void:
	timer.start()
	position.x = GlobalScript.VIEWPORT_SIZE.x+100
	tween = create_tween()
	tween.tween_property(self, "position:x", GlobalScript.VIEWPORT_SIZE.x/2.0, 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	tilt_anim()
func _ready() -> void:
	visible = false
	freeze_timer.wait_time= freeze_time
	timer.wait_time = time
	
	freeze_timer.start()
	
func tilt_anim()->void:
	var new_tween: = create_tween()
	new_tween.tween_property(self,"position:y", position.y + 2, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	new_tween.tween_property(self,"position:y", position.y - 2, 0.5).set_ease(Tween.EASE_IN_OUT)
	new_tween.set_loops(50)
func dissapear_anim()->void:
	tween = create_tween()
	tween.tween_property(self, "position:x", -250, 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
func _on_timer_timeout() -> void:
	dissapear_anim()
func set_time(v:int)->void:
	timer.wait_time = v
func _on_freeze_timer_timeout() -> void:
	visible = true
	init_message()
