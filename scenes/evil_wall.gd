extends Node2D

@onready var left = $left
@onready var right = $right
@onready var up = $up
@onready var down = $down



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_wall(wall:Node2D, distance: float, speed: float):
	#moves the whole wall forward by distance at speed 
	pass
	
func move_tentacles(wall:Node2D, distance: float, speed: float, range_start: int, range_end:int):
	#moves tentacles range_start to range_end by distance at speed
	pass
