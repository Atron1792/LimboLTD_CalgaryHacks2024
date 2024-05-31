extends Button

#handle pausing
@onready var paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta):
	#TODO bug when pressing pause in main menu
	if(Input.is_action_pressed("pause_game")):
		paused = true
		$"../..".visible = true
		#print(get_tree())
		#.find_child("MainScene").visible = false
		get_tree().paused = true
	#TODO pause timea
	#TODO center div

func _on_pressed():
	print(paused)
	if paused:
		#This isn't workign the first time
		text = "Resume"
		$"../..".visible = false
		#get_tree().find_child("MainScene").visible = true
		get_tree().paused = false
	else:
		text = "Start"
		var simultaneous_scene = preload("res://scenes/main_scene.tscn").instantiate()
		get_tree().root.add_child(simultaneous_scene)
		$"../..".visible = false
