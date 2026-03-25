extends Node
func set_values(score: String, level: String)->void:
	$score_level.set_text("YOUR SCORE: "+score+"\n"+"MAX LEVEL : "+level)
