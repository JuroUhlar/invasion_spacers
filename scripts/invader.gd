extends Area2D

export (PackedScene) var bullet
export (String) var shoot_key
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")


func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed(shoot_key):
		if gun_timer.time_left == 0:
			shoot()

func shoot():
	gun_timer.start()
	var b = bullet.instance()
	bullet_container.add_child(b)
	b.start_at(get_node("muzzle").global_position)
