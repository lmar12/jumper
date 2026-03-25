extends Node
class_name Pausable
var paused : bool = false
func pause()->void:
	paused = true
	set_process(false)
func resume()->void:
	paused = false
	set_process(true)
