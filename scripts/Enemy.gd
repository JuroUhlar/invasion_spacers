extends Area2D

export var movement_margin = 100
export var speed = 200
export var health = 100
export var bullet_damage = 20
var velocityV2 = Vector2()
var screen_size

export (PackedScene) var bullet
export (PackedScene) var explosion

onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")
onready var health_bar = get_node("health_bar")
onready var death_timer = get_node("death_timer")
onready var sprite = get_node("Sprite")

func _ready():
	velocityV2.x = speed
	add_to_group("enemies")
	health_bar.value = health
	screen_size = get_viewport_rect().size
	

func shoot():
	gun_timer.start()
	var b = bullet.instance()
	bullet_container.add_child(b)
	b.start_at(get_node("muzzle").global_position)
	

func _physics_process(delta):
	if death_timer.is_stopped():
		position = position + velocityV2 * delta
		if gun_timer.time_left == 0:
			shoot()
	
	if position.x > screen_size.x - movement_margin:
		velocityV2.x = -speed
	if position.x < movement_margin:
		velocityV2.x = speed
		
func _on_Enemy_area_entered(area):
	if area.get_groups().has("player_bullets"):
		take_damage(bullet_damage)	
		
func take_damage(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		var expl = explosion.instance()
		get_parent().add_child(expl)
		expl.position = position
		sprite.visible = false
		health_bar.visible = false
		expl.play()
		death_timer.start()
		
func _on_death_timer_timeout():
	queue_free()
	get_tree().reload_current_scene()
