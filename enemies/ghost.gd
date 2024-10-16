extends CharacterBody2D

var move_speed:float = 8000.0
@onready var nav_agent = $"NavigationAgent2D"
@onready var sprite = $AnimatedSprite2D
@onready var scream_area = $scream_area
var player
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
	
	call_deferred("get_player")
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(player.position)

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
	nav_agent.target_position = target

func move_action(delta):
	set_movement_target(player.position)
	velocity = global_position.direction_to(nav_agent.get_next_path_position()) * move_speed * delta
	move_and_slide()
	scream_timer -= delta
	
	
	
		
func scream_action(_delta):
	sprite.animation = "screaming"
	if sprite.frame == 3:
		var scream_sound = $AudioStreamPlayer
		scream_sound.play()
		scream_area.enabled = true
		modulate = Color(0.7,0.7,1)
	if(sprite.frame == 6):
		state = MOVE
		modulate = Color(1,1,1)
		scream_area.enabled = false
		sprite.animation = "default"

func die_action(delta):
	if not has_scored:
		player.score += 1
		has_scored = true
	death_timer -= delta
	if (death_timer <= 0):
		queue_free()

func get_player():
	player = get_parent().player

func _on_enemy_hurtbox_area_entered(_area):
	if(ghost_health > 0):
		ghost_health = ghost_health - 1
	if (ghost_health <= 0):
		state = DIE
	#TODO color change for a bit

func _on_timer_timeout():
	state = SCREAM

func _on_scream_area_area_entered(_area):
	if state == MOVE and scream_timer < 0:
		scream_timer = 2
		state = SCREAM
