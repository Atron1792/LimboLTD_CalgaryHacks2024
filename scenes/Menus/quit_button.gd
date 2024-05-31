extends Button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _button_pressed():
	print("quit2")
	get_tree().quit()

func _on_pressed():
	print("quit")
	get_tree().quit()
