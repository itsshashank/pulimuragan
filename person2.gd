extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Xrange1 = get_pos().x + 100
var Xrange2 = get_pos().x - 100
var Xrange = [Xrange1,Xrange2]
var x = 0
var flag = 0
func _ready():
	set_fixed_process(true)
func _fixed_process(delta):
	change_pos(x)
func change_pos(x):
	if x == 1:
		move_to(Vector2(10000,0))
	if flag == 0:
		get_node("Sprite/AnimationPlayer").play("animation")
		flag = 1