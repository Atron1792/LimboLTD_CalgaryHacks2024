extends Node2D

var placeholder_enemy_scene = load("res://scenes/mob.tscn")
var eye_scene = load()
@onready var timer = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	#print(timer)
	if timer < 0:
		print("spawning")
	#	spawn_placeholder(100,100)
		timer = 2
	pass
	

func spawn_placeholder(position_x, position_y):
	var placeholder_enemy = placeholder_enemy_scene.instantiate()
	placeholder_enemy.position = Vector2(position_x, position_y)
	add_child(placeholder_enemy)


func _on_eye_spawner_timeout():
	var eye = eye_scene.instantiate()
	pass # Replace with function body.


func _on_placeholder_spawn_timeout():
	print("timer")
	spawn_placeholder(200,200)
	pass # Replace with function body.
