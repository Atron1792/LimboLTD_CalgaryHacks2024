extends Node2D

var health
onready var health0 = $Heart0
onready var health1 = $Heart1
onready var health2 = $Heart2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	health = 6
	health0.frame = 0
	health1.frame = 0
	health2.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	health0.frame = 0
	health1.frame = 0
	health2.frame = 0
	
	match health:
		6:
			pass
		5:
			health2.frame = 1
		4:
			health2.frame = 2
		3:
			health1.frame = 1
			health2.frame = 2
		2:
			health1.frame = 2
			health2.frame = 2
		1:
			health0.frame = 1
			health1.frame = 2
			health2.frame = 2
		0:
			health0.frame = 2
			health1.frame = 2
			health2.frame = 2
	
func take_damage():
	if health <= 0:
		health -= 1
