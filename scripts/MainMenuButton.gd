extends Button

export (PackedScene) var titleScreenScene

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to(titleScreenScene)
