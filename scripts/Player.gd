extends CharacterBody2D

@export var speed = 14000

@onready var sprite = $AnimatedSprite2D

var bullet_scene = load("res://Player/bullet.tscn")



enum {
	MOVE,
	FROZEN,
	DIE
}


enum {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

var state = MOVE
var direction = RIGHT
var shoot_timer = 0

func get_input():
	#var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	return  Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func _physics_process(delta):
	
	match state:
		MOVE:
			move_function(delta)
		FROZEN:
			frozen_function()
		DIE:
			pass
	

func move_function(delta):
	var input_vector = get_input()
	velocity = input_vector * speed * delta
	move_and_slide()
	
	shoot_timer -= delta
	#TODO change to shoot action?
	if Input.is_action_pressed("ui_accept") and shoot_timer < 0:
		shoot_bullet()
		shoot_timer = 0.5
	
	#decide direction
	#priority on left/right
	#up/down is set first so it will be overwrittens
	#There is a better way of doing this

	if(input_vector.y != 0 and input_vector.y < 0):
		direction = UP
	elif(input_vector.y != 0):
		direction = DOWN
	#input_vector.y > 0 ? direction = UP : direction = DOWN
	if(input_vector.x != 0 and input_vector.x > 0):
		direction = RIGHT
	elif(input_vector.x != 0):
		direction = LEFT
	
	#print(input_vector)
	#handle animations
	animations_moving()

func animations_moving():
	match direction:
		RIGHT:
			sprite.scale.x = 1
			sprite.animation = "walk_right"
		UP:
			sprite.scale.x = 1
			sprite.animation = "walk_up"
		LEFT:
			sprite.scale.x = -1
			sprite.animation = "walk_right"
		DOWN:
			sprite.scale.x = 1
			sprite.animation = "walk_down"

func frozen_function():
	pass

func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	if(direction == RIGHT or direction == LEFT):
		bullet.position.y += 10
	bullet.direction = direction
	
	get_parent().add_child(bullet)
	
	
	
	
	
