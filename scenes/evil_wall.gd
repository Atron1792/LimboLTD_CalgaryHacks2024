extends Node2D

@onready var left = $left
@onready var right = $right
@onready var up = $up
@onready var down = $down

var left_target = 0
var right_target = 0
var up_target = 0
var down_target = 0

var left_speed = 0
var right_speed = 0
var up_speed = 0
var down_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = func move_tentacle(tentacle:Node2D, target: float, speed: float):
		if((tentacle.parent.name == "left" or tentacle.parent.name == "right")):
			if(tentacle.position.x < target):
				tentacle.position.x += speed * delta
			else:
				pass
		if((tentacle.parent.name == "down" or tentacle.parent.name == "top")):
			if(tentacle.position.y < target):
				tentacle.position.y += speed * delta
			else:
				pass
		else:
			pass 

#func move_wall(wall:Node2D, distance: float, speed: float):
	#moves the whole wall forward by distance at speed
	#if position < distance:
	#	position += speed * delta
	#wall.position += Vector2(distancex, distancey)
	
func move_tentacles(wall:Node2D, distance: float, speed: float, range_start: int, range_end:int):
	#moves tentacles range_start to range_end by distance at speed
	pass
