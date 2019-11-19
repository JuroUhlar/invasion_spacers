extends Area2D

export (PackedScene) var bullet
export (PackedScene) var explosion

export (String) var shoot_key
export (bool) var active = true
export (NodePath) var backupInvaderPath

onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")
onready var tweenNode = get_node("Tween")

var tweenValues
signal invader_dead

func _ready():
	add_to_group("invaders")
	
	tweenValues = [position, position + Vector2(60,0)]
	start_tween()
	

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
		
func start_tween():
	tweenNode.interpolate_property(self, "position", tweenValues[0], tweenValues[1], 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tweenNode.start()


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
	emit_signal("invader_dead")
	if (backupInvaderPath != null):
		var backup = get_node(backupInvaderPath)
		if (backup): 
			backup.activate()
	queue_free()

func _on_Tween_tween_completed(object, key):
	tweenValues.invert()
	start_tween()
