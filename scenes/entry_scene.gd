extends Node
@onready var title: Label = $Title
@onready var info: Label = $Info
@onready var score: Label = $Score

func _ready() -> void:
	GlobalScript.update_global_score(0)
	score.set_text("BEST SCORE: "+str(GlobalScript.best_score))

func _process(delta: float) -> void:
	if(GlobalScript.best_score!=0):
		score.visible = true
	else:
		score.visible = false
	await get_tree().create_timer(1).timeout
	if(Input.is_action_just_pressed("jump_player")):
		get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
