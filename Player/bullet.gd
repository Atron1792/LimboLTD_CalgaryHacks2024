extends Node2D

enum {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

var speed = 700
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	#offsets so it aligns with te gun
	match direction:
		RIGHT:
			position.y += 10
		LEFT:
			position.y += 10
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match direction:
		RIGHT:
			position.x += speed * delta
		UP:
			position.y -= speed * delta
		LEFT:
			position.x -= speed * delta
		DOWN:
			position.y += speed * delta
			
	

func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	queue_free()
	pass # Replace with function body.
