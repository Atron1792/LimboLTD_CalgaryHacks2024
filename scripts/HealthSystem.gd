extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var health = 6
	$Heart0.set_frame(0)
	$Heart1.set_frame(0)
	$Heart2.set_frame(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var health
	if health == 6:
		pass
	elif health == 5:
		$Heart2.set_frame(1)
	elif health == 4:
		$Heart2.set_frame(2)
	elif health == 3:
		$Heart1.set_frame(1)
	elif health == 2:
		$Heart1.set_frame(2)
	elif health == 1:
		$Heart1.set_frame(1)
	elif health == 0:
		$Heart1.set_frame(2)
	
	if Input.is_action_pressed("ui_accept"):
		take_damage()

func take_damage():
	var health
	health -= 1
	if health <= 0:
		health = 0
