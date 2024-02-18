extends CollisionShape2D

var timer
var set_collision_layer_value

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_wait_time(2)  # Duration of temporary collision disable (in seconds)
	timer.connect("timeout", self, "_on_timeout")
	add_child(timer)
	timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeout():
	set_collision_layer_value = 3
	timer.queue_free()
