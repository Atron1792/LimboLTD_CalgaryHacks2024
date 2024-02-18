extends Node2D

var player

@onready var left = $left
@onready var right = $right
@onready var top = $top
@onready var bottom = $bottom

var left_target = 0
var right_target = 0
var up_target = 0
var down_target = 0

var left_speed = 0
var right_speed = 0
var up_speed = 0
var down_speed = 0


var left_tentacles
var right_tentacles
var down_tentacles
var up_tentacles

var time_total = 0
var room_anger = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#left.position.x = 1
	var _index = 0
	#for tentacle in left.get_children():
	#	left_tentacles[index][0] = tentacle
	#	index += 1
	#index = 0
	#var left_tentacles = left.get_children()
	#var right_tentacles = right.get_children()
	#var down_tentacles = down.get_children()
	#var up_tentacles = up.get_children()
	pass # Replace with function body.
	call_deferred("get_player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_total += delta
	room_anger = time_total - player.score
	print("room anger = ", room_anger, "time = ", time_total, "score = ", player.score)
	#TODO move walls individually
	#TODO these numbers will all have to be refined
	if(room_anger < 5):
		move_walls(-1, 50, delta)
	else:
		move_walls(1, room_anger * 10, delta)
	pass
	
func move_tentacle(tentacle:Node2D, target: float, _speed: float):
	if((tentacle.parent.name == "left" or tentacle.parent.name == "right")):
		if(tentacle.position.x < target):
			pass
			#tentacle.position.x += speed * delta
		else:
			pass
	if((tentacle.parent.name == "down" or tentacle.parent.name == "top")):
		if(tentacle.position.y < target):
			pass
			#tentacle.position.y += speed * delta
		else:
			pass
	else:
		pass 

#func move_wall(wall:Node2D, distance: float, speed: float):
	#moves the whole wall forward by distance at speed
	#if position < distance:
	#	position += speed * delta
	#wall.position += Vector2(distancex, distancey)

#make direction 1 for in, -1 for out
func move_walls(direction:int, speed:float, delta):
	
	#left.position.x = 200
	#top.position.y = 100
	#left.position.x += speed * direction * delta
	left.position.x  += speed * delta * direction
	left.position.x = clamp(left.position.x, 0, 130)
	
	right.position.x  -= speed * delta * direction
	right.position.x = clamp(right.position.x, 670, 800)
	
	top.position.y  += speed * delta * direction
	top.position.y = clamp(top.position.y, 0, 130)
	
	bottom.position.y  -= speed * delta * direction
	bottom.position.y = clamp(bottom.position.y, 470, 600)
	
	pass

func get_player():
	player = get_parent().find_child("Player")

func move_tentacles_bad(_wall:Node2D, _distance: float, _speed: float, _range_start: int, _range_end:int):
	#moves tentacles range_start to range_end by distance at speed
	pass

func set_target_all_walls(target: float):
	left_target = target
	#right_target = 			
	














