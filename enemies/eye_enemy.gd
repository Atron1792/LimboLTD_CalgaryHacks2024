extends KinematicBody2D

enum {
	MOVE,
	DIE
}

var player = 0
var tear_scene = load("res://enemies/tears.tscn")
var type_eye_enemy = true
var has_scored = false
var laser_scene = load("res://enemies/laser.tscn")
var direction
var state = MOVE

export var health = 4
export var tear_timer = 5	
export var laser_timer = 2 

signal spawn_tear

# Called when the node enters the scene tree for the first time.
func _ready():
	#call_deferred("connect_to_parent")
	call_deferred("get_player")
	
	$tear_spawner.wait_time = tear_timer
	$laser_rate.wait_time = laser_timer
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		MOVE:
			move_function(delta)
		DIE:
			die_function(delta)
	
func connect_to_parent():
	get_parent().connect("spawn_tear", get_parent(), "_on_tear_spawn", [position])

func get_player():
	player = get_parent().player

func shoot():
	pass

func move_function(delta):
	if health <= 0:
		state = DIE
	#TODO add movement
	pass

func die_function(delta):
	if not has_scored:
		player.score += 1
		has_scored = true
	#TODO death animation?
	queue_free()


func _on_laser_rate_timeout():
	var laser = laser_scene.instance()
	laser.player = player
	laser.position.x = position.x
	laser.position.y = position.y - 40
	laser.target = laser.position.direction_to(player.position)
	get_parent().get_parent().add_child(laser)
	
func _on_enemy_hurtbox_area_entered(area):
	health -= 1


func _on_tear_spawner_timeout():
	#var tear = tear_scene.instance()
	#tear.position = position
	#get_parent().add_child(tear)
	emit_signal("spawn_tear", self)
	print("spawn")
