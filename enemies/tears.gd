extends RigidBody2D

var move_speed:float = 200.0

enum {
	MOVE = 0,
	DIE = 1
}

var state = MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	match state:
		MOVE:
			move_action()
		DIE:
			die_action()
		
	 
	pass # Replace with function body.

func move_action():
	
	pass
	
func die_action():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
