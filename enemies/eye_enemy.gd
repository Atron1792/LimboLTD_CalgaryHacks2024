extends RigidBody2D

var player = 0
var tear_scene = load("res://enemies/tears.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("get_player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("eye alive")
	pass

func get_player():
	player = get_parent().player

func shoot():
	pass
	
func spawn_tear():
	pass
	



func _on_tear_spawn_timeout():
	var tear = tear_scene.instantiate()
	tear.position = position
	get_parent().add_child(tear)
	#pass # Replace with function body.
