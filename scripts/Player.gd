extends CharacterBody2D

@export var speed = 14000

enum {
	MOVE,
	FROZEN,
	DIE
}

var state = MOVE
var shoot_timer = 0

func get_input():
	#var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	return  Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func _physics_process(_delta):
	
	match state:
		MOVE:
			move_function(delta)
	
	

func move_function(delta):
	velocity = get_input() * speed * delta
	move_and_slide()
	
	shoot_timer -= delta
	#TODO change to shoot action?
	if Input.is_action_pressed("ui_accept") and shoot_timer < 0:
		shoot_bullet()
		
func shoot_bullet():
	
	
	
	
	
	
