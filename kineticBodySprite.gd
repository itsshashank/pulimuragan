extends KinematicBody2D

var onAir = 0
var on_air_time = 100
var a = 6
var t = 0
func get_acc(t):
	return(Vector2(0,0.5*a*t*t))
var GRAVITY = Vector2(0,5)
var TIME = 100
var MIN = 0.8
var MAX = 5
var restTime = 0
var restflag = 0             
var restOverflow = 75        # used to check the excess rest time 
var animation_speed = MIN    # used to set the animation time 
var animation_type  # this will store the animation to be played at present
var SPEEDx = 0
var SPEEDy = 0
var entry = 0
var maxXspeed = 15
var maxYspeed = 18
var jumping = false
var running = false
var attacking = false
var jumpingSpeed = 15
var beforeJump = get_pos().y
var pre_animation = ""
var flag = 0
var attackingTime = 0
var attackOverflow = 25
var health = 100
var deadFlag = 0
var r = 0
var deadCount = 0 
var gameStatus = 0
var gameOverFlag = 0
var x = 0
var points = 0
var takePerson = 0
var SafePosition_1_X_Init = -400
var SafePosition_1_X_Fin = 900
var SafePosition_2_X_Init = 8600
var SafePosition_2_X_Fin = 11100
var SafePosition_1_Y_Init = -1900
var SafePosition_1_Y_Fin = -1600
var SafePosition_2_Y_Init = -600
var SafePosition_2_Y_Fin = -200
var numberOfPeople = 0
func AtSafePosition():
	if( int(get_pos().x) in range(SafePosition_1_X_Init,SafePosition_1_X_Fin)):
		if int(get_pos().y) in range(SafePosition_1_Y_Init,SafePosition_1_Y_Fin):
			return(1)
	if( int(get_pos().x) in range(SafePosition_2_X_Init,SafePosition_2_X_Fin)):
		if int(get_pos().y) in range(SafePosition_2_Y_Init,SafePosition_2_Y_Fin):
			return(2)
	return(0)
func _ready():
	if x == 0:
		x = set_fixed_process(true)
	
#this function will contain the running, attacking ,jumping and dead animation
func _fixed_process(delta):
	if (AtSafePosition() == 1 or AtSafePosition() == 2 )and takePerson == 1:
		takePerson = 0
		points+=10
		#r = AtSafePosition()
		#if r == 1:
		#	SafePosition_1_X_Init = -1234456
		#	SafePosition_1_X_Fin = -12345235
		#if r == 2:
		#	SafePosition_2_X_Init = -1234456
		#	SafePosition_2_X_Fin = -12345235
		numberOfPeople += 1
		print("hello i am here. . .")
		print(numberOfPeople)
		get_node("camara/PeopleGot").set_text(str(numberOfPeople))
		
	if x == 1 or get_pos().y>= 6000 or int(health) <= 0 or int(TIME) <= 0:
		get_node("camara/Label 5").set_text("GAME OVER")
		get_node("camara/Label 4").set_text("")
		get_node("camara/Label").set_text("")
		get_node("camara/Label 2").set_text("")
		get_node("camara/Label 3").set_text("")
		get_node("camara/PeopleGot").set_text("")
		get_node("camara/Label 6").set_text("")
		get_node("camara/Label 7").set_text("")
		var pos = get_node("camara/Label 5").get_pos() 
		get_node("camara/POINTS").set_pos(pos+Vector2(500,1000))
		get_node("camara/POINTS").set_text(str(int(points)))
		gameOverFlag = 1
	if numberOfPeople == 3:
		get_node("camara/Label 5").set_text("YOU WON")
		get_node("camara/Label 4").set_text("")
		get_node("camara/Label").set_text("")
		get_node("camara/Label 2").set_text("")
		get_node("camara/Label 3").set_text("")
		get_node("camara/PeopleGot").set_text("")
		get_node("camara/Label 6").set_text("")
		get_node("camara/Label 7").set_text("")
		var pos = get_node("camara/Label 5").get_pos() 
		get_node("camara/POINTS").set_pos(pos+Vector2(500,1000))
		gameOverFlag = 1
		get_node("camara/POINTS").set_text(str(int(points)))
	TIME -= 0.01
	if gameOverFlag!=1:
		get_node("camara/Label 4").set_text(str(int(TIME)))
		get_node("camara/POINTS").set_text(str(int(points)))
	var velocity = Vector2(SPEEDx,SPEEDy)
	if deadFlag == 1:
		deadCount+=1
	if deadCount >= 50:
		gameStatus = 1
		get_node("Sprite/playerSprite/playerAnimation").stop()
		return(1)
	if health <100 and health>0:
		health+=0.005
	if(Input.is_key_pressed(KEY_SHIFT) and deadFlag!=1):
		maxXspeed = 10
		restTime = 0
		restflag = 0
		animation_speed = MAX
		flag = 1
	if(!Input.is_key_pressed(KEY_SHIFT)and deadFlag!=1):
		flag = 0
		maxXspeed = 5
	if(Input.is_key_pressed(KEY_RIGHT)and deadFlag!=1):
		get_node("Sprite/playerSprite").set_flip_h(0)
		restTime = 0
		restflag = 0
		SPEEDx = maxXspeed
		animation_type = "running"
		if flag == 0:
			animation_speed = MIN
		running = true
	elif(Input.is_key_pressed(KEY_LEFT)and deadFlag!=1):
		SPEEDx = -maxXspeed
		restTime = 0
		restflag = 0
		get_node("Sprite/playerSprite").set_flip_h(1)
		animation_type = "running"
		running = true
		if flag == 0:
			animation_speed = MIN
	else:
		SPEEDx = 0
		restflag = 1
		animation_type = "rest"
		if flag == 0:
			animation_speed = MIN
	if(Input.is_key_pressed(KEY_SPACE)and deadFlag!=1):
		animation_type = "attack"
		restTime = 0
		restflag = 0
		attacking = true
	if(Input.is_key_pressed(KEY_SPACE)and!attacking and deadFlag!=1):
		animation_type = "attack"
		animation_speed = MIN
		attacking = true
		restflag = 0
		restTime = 0	
	if(attacking):
		restflag = 0
		restTime = 0
		attackingTime+=1
		animation_speed = MIN
		animation_type = "attack"
	if(attacking and attackingTime >= attackOverflow and deadFlag!=1):
		attacking = false
		maxXspeed = 10
		animation_speed = MIN
		attackingTime = 0
	if(!jumping and is_colliding()):
		SPEEDy = 0
		t = 0
	if(jumping and is_colliding()):
		SPEEDy = 0
		t = 0
	if(jumping and get_pos().y == beforeJump and deadFlag!=1):
		jumping = false
		SPEEDy = 0
		maxXspeed = 10
		animation_speed = MIN
	if(Input.is_key_pressed(KEY_UP)and!jumping and deadFlag!=1):
		SPEEDy = -maxYspeed
		animation_type = "jump"
		maxXspeed = 10
		animation_speed = MIN
		if flag == 0:
			animation_speed = MIN
		jumping = true
		restflag = 0
		restTime = 0
		beforeJump = get_pos().y	
	if(jumping and deadFlag!=1):
		restflag = 0
		restTime = 0
		maxXspeed = 15
		animation_speed = MIN
		SPEEDy = SPEEDy+delta*jumpingSpeed
		animation_type = "jump"
	if(animation_type != "jump" and animation_type != "running" and animation_type != "attack" and deadFlag!=1):
		animation_type = "rest"
		restflag = 1
		if flag == 0:
			animation_speed = MIN
		running = false
	if restflag == 1 and deadFlag!=1:
		restTime+=1
	if restTime >= restOverflow and deadFlag!=1:
		animation_type = "overrest"	
	if health<=0:
		animation_type = "dead"
		health = 0
	if( pre_animation != animation_type )or (flag == 1 and entry ==0) or(flag == 0 and entry == 1 and deadFlag!=1):
		play_animation(animation_type)
	GRAVITY = get_acc(t)
	var floor_velocity = Vector2()
	var motion = Vector2(SPEEDx,SPEEDy)*delta
	motion = move(motion)
	if (is_colliding()):
		# You can check which tile was collision against with this
		# print(get_collider_metadata())
		
		# Ran against something, is it the floor? Get normal
		var n = get_collision_normal()
		if n==Vector2(0,-1):
			t = 0
			jumping = 0
			SPEEDy = 0
			print("Normal")
	#if (floor_velocity != Vector2()):
		# If floor moves, move with floor
	#	move(floor_velocity*delta)
	on_air_time+=delta
	if animation_type != "attack" and deadFlag!=1:
		var velocity = Vector2(SPEEDx,SPEEDy)+get_acc(t)
		var movement_reminder = move(Vector2(SPEEDx,SPEEDy))
		if is_colliding():
			t = 0
			jumping = 0
			SPEEDy = 0
		else:
			t+=0.05
			move(Vector2(SPEEDx,SPEEDy)+get_acc(t))
	else:
		if SPEEDy<0:
			attacking = 0
	if gameOverFlag!=1:
		get_node("camara/Label").set_text(str(int(health)))
		var loaded
		if takePerson == 1:
			loaded = "LOADED"
		else:
			loaded = "UNLOADED"
		get_node("camara/Label 7").set_text(loaded)
func play_animation(animation):
	pre_animation = animation
	if flag == 1:
		entry = 1
	else:
		entry = 0
	if animation == "running":
		if animation_speed==MIN:
			animation_speed = 1.6
		if flag == 1:
			animation_speed = MAX
		get_node("Sprite/playerSprite/playerAnimation").set_speed(animation_speed)
	else:
		animation_speed = MIN
		get_node("Sprite/playerSprite/playerAnimation").set_speed(animation_speed)
	if animation == "attack":
		animation_speed = 1.6
		get_node("Sprite/playerSprite/playerAnimation").set_speed(animation_speed)
	get_node("Sprite/playerSprite/playerAnimation").play(animation)
	if animation == "dead":
		deadFlag = 1
