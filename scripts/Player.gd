extends KinematicBody2D

var speed = 20000

onready var sprite = $AnimatedSprite
onready var health_system = $HealthSystem
onready var shot_sound = $AudioStreamPlayer2D
export var player_size = 1.5

var bullet_scene = load("res://Player/bullet.tscn")

var score = 0
var ammo = 10

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
var invincibility_timer = 0
var frozen_timer = 0.5

func get_input():
	#var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	return  Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func _physics_process(delta):
	
	match state:
		MOVE:
			move_function(delta)
		FROZEN:
			frozen_function(delta)
		DIE:
			dead_function()

func move_function(delta):
	var input_vector = get_input()
	
	
	var velocity = input_vector * speed * delta
	move_and_slide(velocity)
	
	shoot_timer -= delta
	#TODO change to shoot action?
	if Input.is_action_pressed("ui_accept") and shoot_timer < 0 and ammo > 0 :
		shoot_bullet()
		shoot_timer = 0.3
		ammo -= 1
	elif ammo == 0 : 
		shoot_timer = 2
		ammo = 10
	
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
		var hit_sound = $AudioStreamPlayer
		hit_sound.play()
		invincibility_timer -= delta
		pass
	else: 
		sprite.modulate = Color(1, 1, 1)  # Normal
	if(health_system.health == 0):
		state = DIE



func animations_moving(input_vector):
	
	sprite.scale.y = player_size
	
	if input_vector == Vector2.ZERO:
		match direction:
			RIGHT:
				sprite.scale.x = player_size
				sprite.play("idle_right")
			UP:
				sprite.scale.x = player_size
				sprite.play("idle_up")
			LEFT:
				sprite.scale.x = -player_size
				sprite.play("idle_right")
			DOWN:
				sprite.scale.x = player_size
				sprite.play("idle_down")
	else:
		match direction:
			RIGHT:
				sprite.scale.x = player_size
				sprite.play("walk_right")
			UP:
				sprite.scale.x = player_size
				sprite.play("walk_up")
			LEFT:
				sprite.scale.x = -player_size
				sprite.play("walk_right")
			DOWN:
				sprite.scale.x = player_size
				sprite.play("walk_down")

func frozen_function(delta):
	#TODO fix reliability issues
	frozen_timer -= delta
	sprite.modulate = Color(0,0,1)
	if frozen_timer < 0:
		frozen_timer = 0.5
		state = MOVE
		sprite.modulate = Color(1,1,1)
	
	pass

func dead_function():
	#Death animation
	health_system.visible = false
	health_system.top_level = false
	get_parent().find_child("Game_over").visible = true
	pass

func shoot_bullet():
	
	shot_sound.play()
	
	var bullet = bullet_scene.instance()
	bullet.position.x = position.x
	bullet.position.y = position.y - 55
	if(direction == RIGHT or direction == LEFT):
		bullet.position.y += 10
	bullet.direction = direction
	get_parent().add_child(bullet)
	
func _on_hurtbox_area_entered(_area):
	#TODO let area know they hit the player
	#area.get_parent
	#could prob do this through layers and masks
	print(_area.name)
	if(_area.name == "scream_area"):
		if _area.enabled:
			state = FROZEN
	else:
		#print("almost damage = ", invincibility_timer)
		if invincibility_timer <= 0:
			print("damage")
			health_system.health -= 1
			invincibility_timer = 1
	pass # Replace with function body.
