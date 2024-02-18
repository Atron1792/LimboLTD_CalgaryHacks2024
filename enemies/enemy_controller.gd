extends Node2D

var placeholder_enemy_scene = preload("res://scenes/mob.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	 
	pass
	

func spawn_placeholder(position_x, position_y):
	
	var placeholder_enemy = placeholder_enemy_scene.instantiate()
	add_child(placeholder_enemy)
