extends Area2D

export (PackedScene) var bullet
export (PackedScene) var explosion

export (String) var shoot_key
export (bool) var active = true
export (NodePath) var backupInvader
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")

func _ready():
	add_to_group("invaders")

func _process(delta):
	if Input.is_action_pressed(shoot_key):
		if gun_timer.time_left == 0:
			shoot()

func shoot():
	if (active):
		gun_timer.start()
		var b = bullet.instance()
		bullet_container.add_child(b)
		b.start_at(get_node("muzzle").global_position)


func _on_Invader_area_entered(area):
	if area.get_groups().has("enemy_bullets"):
		die()
		
func activate():
	active = true;

func die(): 
	var expl = explosion.instance()
	get_parent().add_child(expl)
	expl.position = position
	expl.play()
	var backup = get_node(backupInvader)
	backup.activate()
	queue_free()