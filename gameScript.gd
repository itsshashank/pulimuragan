extends Node

var currentTiger = ""
var currentPerson = ""
var tigers = ["tiger1","tiger2","tiger3","tiger4","tiger5","tiger6","tiger7"]
var person = ["person1","person2","person3"]
func _ready():
	set_fixed_process(true)
	get_node("player/camara/PanelContainer").set_hidden(true)

func _fixed_process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().change_scene("res://esc.tscn")
	if(Input.is_key_pressed(KEY_P)):
		get_tree().set_pause(true)
		get_node("player/camara/PanelContainer").show()
	for k in tigers:
		var Xrange1 = int(get_node(k).Xrange[0]) 
		var Xrange2 = int(get_node(k).Xrange[1])
		if int(get_node("player").get_pos().x) in range(Xrange1,Xrange2):
			var pY = int(get_node("player").get_pos().y)
			var tY = int(get_node(k).get_pos().y)
			if pY in range(tY-500,tY+500):	
				currentTiger = k
				break
	for p in person:
		var Xrange1 = int(get_node(p).Xrange[0]) 
		var Xrange2 = int(get_node(p).Xrange[1])
		#print(get_node("player").get_pos().x," , ",Xrange1,",",Xrange2)
		if int(get_node("player").get_pos().x) in range(Xrange2,Xrange1):
			var pY = int(get_node("player").get_pos().y)
			var tY = int(get_node(p).get_pos().y)
			if pY in range(tY-500,tY+500):	
				currentPerson = p
				if get_node("player").takePerson != 1:
					get_node(p).Xrange = [200000,200000]
					get_node(p).x = 1
				get_node("player").takePerson = 1
				break
	#print(currentTiger)
	if(tiger_attacking_player()==1 and int(get_node("player").health)>=0):	
		get_node(currentTiger).animation = "attack"
		if get_node(currentTiger).deadFlag == 0:
			get_node("player").health -= 1
	if(player_attacking_tiger()==1):
		get_node(currentTiger).health-= 2
		if(get_node(currentTiger).health < 0):
			get_node(currentTiger).health = 0
func tiger_attacking_player():
	var pX = get_node("player").get_pos().x
	var pY = get_node("player").get_pos().y
	var tX = get_node(currentTiger).get_pos().x
	var tY = get_node(currentTiger).get_pos().y
	pX = int(pX)
	pY = int(pY)
	tX = int(tX)
	tY = int(tY)
	if(pX in range(tX-200,tX+200)):
		if pY in range(tY-200,tY+200):	
			return(1)
	else:
		return(0)
func player_attacking_tiger():
	var pX = get_node("player").get_pos().x
	var pY = get_node("player").get_pos().y
	var tX = get_node(currentTiger).get_pos().x
	var tY = get_node(currentTiger).get_pos().y
	pX = int(pX)
	pY = int(pY)
	tX = int(tX)
	tY = int(tY)
	if(pX in range(tX-200,tX+200)):
		if pY in range(tY-500,tY+500):	
			if get_node("player").animation_type == "attack":
				return(1)
	else:
		return(0)
	
	

func _on_ToolButton_pressed():
	get_node("player/camara/PanelContainer").hide()
	get_tree().set_pause(false)
	pass # replace with function body
