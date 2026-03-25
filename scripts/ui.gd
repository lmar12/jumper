extends Control
@onready var box: HBoxContainer = $HBoxContainer
@onready var BOX_POSITION_Y := box.position.y
@onready var score_label: Label = $HBoxContainer/ScoreLabel
@onready var level_label: Label = $HBoxContainer/LevelLabel
@onready var timer: Timer = $Timer

@export var appear_time : int = 4

func appear_anim()->void:
	var tween:= create_tween()
	tween.tween_property(box, "position:y", BOX_POSITION_Y, 1.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
func dissapear_anim()->void:
	var tween:= create_tween()
	tween.tween_property(box, "position:y", -25, 1.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
func _ready() -> void:
	box.position.y = -25
	timer.wait_time = appear_time
	timer.start()
func appear_ui()->void:
	appear_anim()
func update_level(v: int)->void:
	#update_value
	tilt_ui_component(level_label)
	level_label.text = "LEVEL " +str(v)
func update_score(v: int)->void:
	score_label.text = "SCORE " + str(v)
func _on_timer_timeout() -> void:
	appear_ui()
func tilt_ui_component(v:Label)->void:
	#Animation
	#v.theme.set_font_size(v.the)
	#var tween := create_tween()
	#tween.tween_property(v, "font_size", v.font_size+1, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)
	pass
func game_over()->void:
	dissapear_anim()
	
