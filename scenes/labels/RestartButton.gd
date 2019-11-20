extends Button

func _on_RestartButton_pressed():
	get_tree().reload_current_scene() # Replace with function body.
	
func _process(delta):
	if(self.visible && Input.is_action_just_pressed("ui_accept")):
		get_tree().reload_current_scene() # Replace with function body.
		
