extends Node

onready var victory_label = get_node("Victory label")
onready var defeat_label = get_node("Defeat label")
onready var paused_label = get_node("Paused label")
onready var buttons = get_node("Buttons")
onready var victory_sound = get_node("VictorySound")
onready var defeat_sound = get_node("DefeatSound")


var paused = false;

func _on_Enemy_enemy_dead():
	victory_label.visible = true
	buttons.visible = true
	victory_sound.play()

func _on_InvaderContainer_all_invaders_dead():
	defeat_label.visible = true
	buttons.visible = true
	defeat_sound.play()
	
func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		if(!paused):
			print("Pause game")
			get_tree().paused = true
			paused_label.visible = true
			paused = true
		else:
			print("Unpause game")
			get_tree().paused = false
			paused_label.visible = false
			paused = false
