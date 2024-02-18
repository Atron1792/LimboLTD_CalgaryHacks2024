extends CharacterBody2D

var player = 0
var tear_scene = load("res://enemies/tears.tscn")
var type_eye_enemy = true
var health = 4
var has_scored = false

enum {
	MOVE,
	DIE
}

var state = MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("get_player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		MOVE:
			move_function(delta)
		DIE:
			die_function(delta)
	

func get_player():
	player = get_parent().player

func shoot():
	pass

func move_function(delta):
	if health <= 0:
		state = DIE
	#TODO add movement
	pass

func die_function(delta):
	if not has_scored:
		player.score += 1
		has_scored = true
	#TODO death animation?
	queue_free()


func _on_tear_spawn_timeout():
	var tear = tear_scene.instantiate()
	tear.position = position
	get_parent().add_child(tear)
	emit_signal("tears_spawned", +1)
	#pass # Replace with function body.



func _on_enemy_hurtbox_area_entered(area):
	health -= 1
	
