extends Node2D

var placeholder_enemy_scene = load("res://scenes/mob.tscn")
var eye_scene = load("res://enemies/eye_enemy.tscn")
var ghost_scene = load("res://enemies/ghost.tscn")
@onready var timer = 2
@onready var ghost_timer = $ghost_spawner

var difficulty = 0

var player
#TODO remove one shot from timers

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("get_player")
	pass # Replace with function body.

func get_player():
	player = get_tree().root.find_child("Player", true)#get_parent().find_child("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	difficulty += delta
	ghost_timer.wait_time = difficulty * 2
	
func spawn_placeholder(position_x, position_y):
	var placeholder_enemy = placeholder_enemy_scene.instantiate()
	placeholder_enemy.position = Vector2(position_x, position_y)
	add_child(placeholder_enemy)

func spawn_enemy(enemy_scene, position_x, position_y):
	var instance = enemy_scene.instantiate()
	instance.position = Vector2(position_x, position_y)
	add_child(instance)

func _on_eye_spawner_timeout():
	var eye = eye_scene.instantiate()
	#TODO replace with actual values 
	spawn_enemy(eye_scene, 200, 200)

func _on_placeholder_spawn_timeout():
	spawn_placeholder(200,200)
	pass # Replace with function body.
	
func _on_ghost_spawner_timeout():
	var ghost = ghost_scene.instantiate()
	spawn_enemy(ghost_scene, 300, 300)
	pass # Replace with function body.
