extends Button
var paused = false

#handle pausing




func _on_pressed():
	
	print("changed")
	if paused:
		$"../..".visible = false
		#TODO unpause game
	else:
		var simultaneous_scene = preload("res://scenes/main_scene.tscn").instantiate()
		get_tree().root.add_child(simultaneous_scene)
		$"../..".visible = false
	



