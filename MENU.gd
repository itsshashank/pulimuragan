extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_fixed_process(true)
func _fixed_process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().change_scene("res://esc.tscn")
func _on_Button_pressed():
	get_tree().quit()

func _on_ToolButton_pressed1():
	get_tree().change_scene("res://player.tscn")
	pass # replace with function body


func _on_ToolButton_2_pressed():
	get_tree().change_scene("res://about.tscn")
	pass # replace with function body
