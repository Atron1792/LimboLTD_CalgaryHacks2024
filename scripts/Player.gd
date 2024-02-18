extends CharacterBody2D

@export var speed = 400

enum {
	MOVE,
	FROZEN,
	DIE	
}

func get_input():
	#var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	return  Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func _physics_process(_delta):
	velocity = get_input() * speed
	move_and_slide()

