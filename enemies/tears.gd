extends KinematicBody2D

export var move_speed:float = 8000.0

onready var nav_agent = $"NavigationAgent2D"
onready var sprite = $AnimatedSprite2D

var player
var flashing_timer = 0.2
var type_eye_enemy = false
var has_scored = false

export var death_timer = 10

#1 = right, -1 = left
var facing_direction = 1

enum {
	MOVE,
	DIE,
	DEAD
}

var state = MOVE




# Called when the node enters the scene tree for the first time.
func _ready():
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	
	call_deferred("get_player")
	 
	call_deferred("actor_setup")

func actor_setup():
	var tree = get_parent().get_parent().get_children()

	for i in tree:
		if i.name == "Player":
			player = i


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		MOVE:
			move_action(delta)
		DIE:
			die_action(delta)
		DEAD:
			dead_action(delta)
	sprite.scale.x = facing_direction

func set_movement_target(target: Vector2):
	nav_agent.target_position = target

func move_action(delta):
	set_movement_target(player.position)
	
	velocity = global_position.direction_to(nav_agent.get_next_path_position()) * move_speed * delta
	move_and_slide()
	
	if position.x < player.position.x:
		facing_direction = -1
	else:
		facing_direction = 1

func die_action(delta):
	if not has_scored:
		player.score += 1
		has_scored = true
	sprite.animation = "die"
	if(death_timer < 0):
		queue_free()
	
		
	
	death_timer -= delta
	
func dead_action(delta):
	sprite.animation = "dead"
	
	if flashing_timer < 0:
		sprite.visible = !sprite.visible
		flashing_timer = 0.2
	if(death_timer < 0):
		queue_free()
	if death_timer < 1:
		flashing_timer -= delta
	death_timer -= delta

func get_player():
	player = get_parent().player
	



func _on_enemy_hurtbox_area_entered(area):
	#TODO check if bullet.
	if state == MOVE:
		state = DIE



func _on_animated_sprite_2d_animation_finished():
	state = DEAD
	#print(sprite.animation)
	#if sprite.animation == "die":
	#	print("changed to dead")
	#sprite.animation = "dead"
	#	#sprite.play()
	#print(sprite.animation)
	pass # Replace with function body.
