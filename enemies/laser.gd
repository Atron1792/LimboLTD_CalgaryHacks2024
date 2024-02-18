extends Node2D

var speed = 300
var player
var target
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = position.direction_to(player.position).angle()
	pass
	#player = get_node("res://Player/player.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += target.x * speed * delta
	position.y += target.y * speed * delta
	
	
	
func _on_area_2d_area_entered(area):
	pass # Replace with function body.
