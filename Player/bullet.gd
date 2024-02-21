extends Node2D

enum {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

var speed = 300
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	match direction:
		RIGHT:
			position.x += 10
		LEFT:
			position.x += 10
	pass # Replace with function body.

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
