extends Node2D

var placeholder_enemy_scene = load("res://scenes/mob.tscn")
var eye_scene = load("res://enemies/eye_enemy.tscn")
var ghost_scene = load("res://enemies/ghost.tscn")

var tear_scene = load("res://enemies/tears.tscn")


onready var timer = 2
onready var ghost_timer = $ghost_spawner
onready var eye_timer = $eye_spawner

export var eye_starting_time = 2
export var ghost_starting_time = 2

export var player_export:NodePath


var map


var game_won = false
var destroy_timer = 3
var has_killed_children = false


var difficulty = 0
var eye_enemy_number
var block_eye_spawn
var player
var spawn_rate_increase_timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	eye_timer.wait_time = eye_starting_time
	ghost_timer.wait_time = ghost_starting_time
	call_deferred("get_player")
	#call_deferred("setup_navserver")
	
	

#From tutorial. Bad
func setup_navserver():

	# create a new navigation map
	map = Navigation2DServer.map_create()
	Navigation2DServer.map_set_active(map, true)

	# create a new navigation region and add it to the map
	var region = Navigation2DServer.region_create()
	Navigation2DServer.region_set_transform(region, Transform())
	Navigation2DServer.region_set_map(region, map)

	# sets navigation mesh for the region
	var navigation_poly = NavigationMesh.new()
	navigation_poly = $Navmesh.navpoly
	Navigation2DServer.region_set_navpoly(region, navigation_poly)

	# wait for Navigation2DServer sync to adapt to made changes
	yield(get_tree(), "physics_frame")

func get_player():
	var tree = get_parent().get_children()
	
	
	
	for i in tree:
		if i.name == "Player":
			player = i

	#player = get_tree().root.find_child("Player", true)
	#TODO this is unsafe, find way to find player
	#player = get_parent().get_child(2)
	#print(player)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if game_won:
		kill_all_children()
		
		destroy_timer -= delta
		if destroy_timer < 1.5:
			modulate = Color(1, 0, 0)
		if destroy_timer < 0:
			queue_free()
	else:
		spawn_rate_increase_timer += delta
		if(spawn_rate_increase_timer > 30):
			eye_timer.wait_time *= 0.7
			ghost_timer.wait_time *= 0.7
			spawn_rate_increase_timer = 0
		
		difficulty += delta
		ghost_timer.wait_time = difficulty * 2
		eye_enemy_number = 0
		block_eye_spawn = false
		
		for enemy in get_children():
			if not (enemy is Timer):
				if enemy.type_eye_enemy:
					eye_enemy_number += 1
		if eye_enemy_number >= 3:
			block_eye_spawn = true
		else:
			block_eye_spawn = false
	
func kill_all_children():
	if !has_killed_children:
		has_killed_children = true
		for enemy in get_children():
			if not (enemy is Timer):
				#This sets it to die
				enemy.state = 1

func spawn_placeholder(position_x, position_y):
	var placeholder_enemy = placeholder_enemy_scene.instance()
	placeholder_enemy.position = Vector2(position_x, position_y)
	add_child(placeholder_enemy)

#TODO chage
#make x and y coordinates, plus left/right, up/down.
#spawn at cords, just a bit outside the play area before moving in.
func spawn_enemy(enemy_scene, position_x, position_y):
	var instance = enemy_scene.instance()
	instance.position = Vector2(position_x, position_y)
	add_child(instance)
	

func _on_eye_spawner_timeout():
	if not block_eye_spawn:
		var _eye = eye_scene.instance()
		
		#TODO replace with actual values 
		#TODO do better enemy spawning
		spawn_enemy(eye_scene, randi() % 800, randi() % 600)


func _on_placeholder_spawn_timeout():
	spawn_placeholder(200,200)
	pass # Replace with function body.
	
func _on_ghost_spawner_timeout():
	#spawn_enemy(ghost_scene, 300, 300)
	#var ghost = ghost_scene.instance()
	#print("spaning ghost")
	spawn_enemy(ghost_scene, randi() % 800, randi() % 600)
	#add_child(ghost)
	pass # Replace with function body.

func _on_tear_spawn(eye):
	print("good")
	spawn_enemy(ghost_scene, eye.position, eye.position)
	
