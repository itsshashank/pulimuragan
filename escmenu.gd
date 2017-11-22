extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _ready():
	get_node("PanelContainer").set_hidden(true)
	set_fixed_process(true)
func _fixed_process(delta):
	if(Input.is_key_pressed(KEY_P)):
		get_tree().set_pause(true)
		get_node("PanelContainer").show()
		
	
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().set_pause(true)
		get_tree().change_scene("res://esc.tscn")

func _on_ToolButton_pressed():
	get_node("PanelContainer").hide()
	get_tree().set_pause(false)
	pass # replace with function body


func _on_ToolButton_2_pressed():
	get_tree().change_scene("res://esc.tscn")
	pass # replace with function body
