extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_resume_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://player.tscn")
	
	pass # replace with function body


func _on_ToolButton_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://start.tscn")
	pass # replace with function body
