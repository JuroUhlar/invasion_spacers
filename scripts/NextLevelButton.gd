extends Button

func _ready():
	pass # Replace with function body.

func _on_NextLevelButton_pressed():
	next_level()
	
func _process(delta):
	if(self.visible && Input.is_action_just_pressed("ui_accept")):
		next_level()
		
func next_level():
	Global.level += 1
	get_tree().reload_current_scene()
	
