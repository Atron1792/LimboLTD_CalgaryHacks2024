extends CharacterBody2D

@export var speed = 14000

@onready var sprite = $AnimatedSprite2D

@onready var health_system = $HealthSystem

var bullet_scene = load("res://Player/bullet.tscn")

var score = 0

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
var invincibility_timer = 1

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
			dead_function()

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
	animations_moving(input_vector)
	
	
	if invincibility_timer > 0:
		# Set the color of the sprite to red
		sprite.modulate = Color(1, 0, 0)  # Red
		var hit_sound = $AudioStreamPlayer2
		hit_sound.play("res://sounds/shot.wav")
		invincibility_timer -= delta
		pass
	else: 
		sprite.modulate = Color(1, 1, 1)  # Normal
	if(health_system.health == 0):
		state = DIE

func animations_moving(input_vector):
	if input_vector == Vector2.ZERO:
		match direction:
			RIGHT:
				sprite.scale.x = 1
				sprite.play("idle_right")
			UP:
				sprite.scale.x = 1
				sprite.play("idle_up")
			LEFT:
				sprite.scale.x = -1
				sprite.play("idle_right")
			DOWN:
				sprite.scale.x = 1
				sprite.play("idle_down")
	else:
		match direction:
			RIGHT:
				sprite.scale.x = 1
				sprite.play("walk_right")
			UP:
				sprite.scale.x = 1
				sprite.play("walk_up")
			LEFT:
				sprite.scale.x = -1
				sprite.play("walk_right")
			DOWN:
				sprite.scale.x = 1
				sprite.play("walk_down")

func frozen_function():
	pass

func dead_function():
	#Death animation
	get_parent().find_child("Game_over").visible = true
	pass

func shoot_bullet():
	var shot_sound = $AudioStreamPlayer
	shot_sound.play()
	
	var bullet = bullet_scene.instantiate()
	bullet.position.x = position.x
	bullet.position.y = position.y - 55
	if(direction == RIGHT or direction == LEFT):
		bullet.position.y += 10
	bullet.direction = direction
	get_parent().add_child(bullet)
	
func _on_hurtbox_area_entered(_area):
	#TODO let area know they hit the player
	#area.get_parent
	print("hit")
	if invincibility_timer < 0:
		print("damage")
		health_system.health -= 1
		invincibility_timer = 1
	pass # Replace with function body.
