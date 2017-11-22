extends KinematicBody2D

var attackDirection = -1
var currentPos = 0
var attackAnimationSpeed = 3
var health = 100
var goingRIGHT = 1
var end = 0
var maxXspeed = 5
var SPEEDx = 0
var timer = 0
var extreem = 450
var flag = 1
var deadFlag = 0
var deadTimer = 0
var animation = ""
var attacking = 0
var RedirectFlag = 0
var attackingTime = 0
var attackingMaxTime = 50
const stageInitalX = 6600
const stageFinalX = 9300
var Xrange = [6600,9300]
func _ready():	
	set_fixed_process(true)
func _fixed_process(delta):
	if flag == 1 and deadFlag == 0 and attackDirection==-1:
		get_node("AnimatedSprite/AnimationPlayer").play("tiger_animation")
		flag = 0
	if goingRIGHT == 1 and end  == 0 and deadFlag == 0 and attackDirection==-1:
		SPEEDx = maxXspeed
	if goingRIGHT == 1 and end == 1 and deadFlag == 0 and attackDirection==-1:
		get_node("AnimatedSprite").set_flip_h(1)
		goingRIGHT = 0
		end = 0
		SPEEDx = -maxXspeed
	if animation == "attack" and attacking!=1 and deadFlag == 0:
		get_node("AnimatedSprite/AnimationPlayer").play("tiger_attack")
		attackingTime = 0
		attacking = 1
	if attacking == 1:
		SPEEDx = 0
		attackingTime+=1
	if (attackingTime == attackingMaxTime) and deadFlag == 0:
		get_node("AnimatedSprite/AnimationPlayer").stop()
		get_node("AnimatedSprite/AnimationPlayer").play("tiger_animation")
		attacking = 0
		attackingTime = 0
		animation = ""
	if goingRIGHT == 0 and end  == 0 and deadFlag == 0 and attackDirection==-1:
		SPEEDx = -maxXspeed
	if goingRIGHT == 0 and end == 1 and deadFlag == 0 and attackDirection==-1:
		get_node("AnimatedSprite").set_flip_h(0)
		goingRIGHT = 1
		end = 0
		SPEEDx = maxXspeed
	if get_pos().x>=stageFinalX and deadFlag == 0 and RedirectFlag == 0:
		end = 1
		get_node("AnimatedSprite/AnimationPlayer").play("tiger_animation")
		RedirectFlag = 1
		goingRIGHT = 1
	elif get_pos().x <= stageInitalX and deadFlag == 0 and RedirectFlag == 0:
		end = 1
		RedirectFlag = 1
		goingRIGHT = 0
		get_node("AnimatedSprite/AnimationPlayer").play("tiger_animation")
	else:
		RedirectFlag = 0
	move(Vector2(SPEEDx,0))
	get_node("Label").set_text(str(health))
	if(health <= 0 and deadFlag!= 2):
		deadFlag = 1
		health = 0
	
	if deadFlag == 1:
		deadFlag = 2
		SPEEDx = 0
		get_node("AnimatedSprite/AnimationPlayer").set_speed(1)	
		get_node("AnimatedSprite/AnimationPlayer").play("tiger_dead")
	if deadFlag == 2:
		deadTimer+=1
		health = 0
	if deadTimer >= 50:
		health = 0
		get_node("AnimatedSprite/AnimationPlayer").stop()

