extends Node2D

var speed = 300
var direction
var player
var player_position

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("res://Player/player.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_position = player.position
	
	direction.x = (player_position - position.x).normalized()
	position.x += (direction.x * speed * delta) 
	
	direction.y = (player_position - position.y).normalized()
	position.y += (direction.y * speed * delta) 
	
func _on_area_2d_area_entered(area):
	pass # Replace with function body.
