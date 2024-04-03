extends KinematicBody2D


#Holy mother of collision shapes
var move_speed:float = 8000.0
onready var nav_agent = $"NavigationAgent2D"
onready var sprite = $AnimatedSprite
onready var scream_area = $scream_area
onready var scream_hitbox = $scream_hitbox
onready var scream_hitbox_shape = $scream_hitbox/CollisionShape2D

var player:KinematicBody2D
var type_eye_enemy = false
var has_scored = false

enum {
	MOVE,
	DIE,
	SCREAM
}

var state = MOVE
var ghost_health = 2
var death_timer = 1
var scream_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	
	scream_hitbox.monitorable = false
	
	sprite.play("idle")
	#call_deferred("get_player")
	#call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	#TODO make this work for 3.5
	#yield(get_tree(), "main_scene")
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
		SCREAM:
			scream_action(delta)
		

func set_movement_target(target: Vector2):
	nav_agent.set_target_location(target)

func move_action(delta):
	
	set_movement_target(get_parent().player.position)
	
	#TODO movement
	var velocity = global_position.direction_to(nav_agent.get_next_location()) * move_speed * delta
	
	move_and_slide(velocity)
	scream_timer -= delta
	
		
func scream_action(delta):
	#sprite.animation = "screaming"
	sprite.play("scream")
	if sprite.frame == 3:
		var scream_sound = $AudioStreamPlayer2D
		scream_sound.play()
		#scream_hitbox_shape = 
		scream_hitbox.monitorable = true
		modulate = Color(0.7,0.7,1)
	if(sprite.frame == 6):
		state = MOVE
		modulate = Color(1,1,1)
		scream_hitbox.monitorable = false
		sprite.play("idle")

func die_action(delta):
	modulate = Color(1,0.5,0.5)
	if not has_scored:
		get_parent().player.score += 1
		has_scored = true
	death_timer -= delta
	if (death_timer <= 0):
		queue_free()

func get_player():
	player = get_parent().player

func _on_enemy_hurtbox_area_entered(area):
	if(ghost_health > 0):
		ghost_health = ghost_health - 1
	if (ghost_health <= 0):
		state = DIE
	#TODO color change for a bit

func _on_timer_timeout():
	state = SCREAM
	


#This doesn't actually do anything.
func _on_scream_area_area_entered(area):
	
	
	print("screaming")
	if state == MOVE and scream_timer < 0:
		scream_timer = 2
		state = SCREAM


func _on_scream_area_body_entered(body):
	
	if state == MOVE and scream_timer < 0:
		scream_timer = 2
		state = SCREAM
		
