extends Button


func _button_pressed():
	print("quit2")
	get_tree().quit()


func _on_pressed():
	print("quit")
	get_tree().quit()
