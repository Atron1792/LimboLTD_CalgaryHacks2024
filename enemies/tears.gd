extends CharacterBody2D

var move_speed:float = 200.0
@onready var nav_agent = $"NavigationAgent2D"
var player

enum {
	MOVE = 0,
	DIE = 1
}

var state = MOVE



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
			move_action()
		DIE:
			die_action()
	pass

func set_movement_target(target: Vector2):
	nav_agent.target_position = target

func move_action():
	set_movement_target(player.position)
	
	velocity = global_position.direction_to(nav_agent.get_next_path_position()) * move_speed
	move_and_slide()
	
func die_action():
	pass

func get_player():
	player = get_parent().player

