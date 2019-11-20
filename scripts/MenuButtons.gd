extends VBoxContainer

func _on_StartButton_pressed():
	get_tree().change_scene('res://scenes/World.tscn')
	
func _process(delta):
	if(self.visible && Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene('res://scenes/World.tscn')

func _on_QuitButton_pressed():
	get_tree().quit()
