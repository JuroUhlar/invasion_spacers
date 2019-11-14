extends Area2D

export var movement_margin = 100
export var speed = 200
export var health = 100
var velocityV2 = Vector2()
var screen_size

export (PackedScene) var bullet
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")

func _ready():
	velocityV2.x = speed
	add_to_group("enemies")
	screen_size = get_viewport_rect().size
	

func shoot():
	gun_timer.start()
	var b = bullet.instance()
	bullet_container.add_child(b)
	b.start_at(get_node("muzzle").global_position)
	

func _physics_process(delta):
	position = position + velocityV2 * delta
	
	if position.x > screen_size.x - movement_margin:
		velocityV2.x = -speed
	if position.x < movement_margin:
		velocityV2.x = speed
		
	if gun_timer.time_left == 0:
			shoot()

func _on_Enemy_area_entered(area):
	if area.get_groups().has("player_bullets"):
		health -= 20
		print(area.name)
		if health <= 0:
			queue_free()
			get_tree().reload_current_scene()
