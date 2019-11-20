extends Node

onready var invaderCount = get_child_count()
onready var checking = true

signal all_invaders_dead

func _ready():
	print(self.get_path())

func _process(delta):
	if (checking):	
		if (get_child_count() == 0):
			emit_signal("all_invaders_dead")
			print("all invaders dead")
			checking = false