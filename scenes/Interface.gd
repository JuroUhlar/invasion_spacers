extends Node

onready var victory_label = get_node("Victory label")
onready var defeat_label = get_node("Defeat label")
onready var buttons = get_node("Buttons")

func _on_Enemy_enemy_dead():
	victory_label.visible = true
	buttons.visible = true

func _on_InvaderContainer_all_invaders_dead():
	defeat_label.visible = true
	buttons.visible = true
