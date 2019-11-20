extends Button

func _ready():
	pass # Replace with function body.

func _on_NextLevelButton_pressed():
	Global.level += 1
	get_tree().reload_current_scene()
