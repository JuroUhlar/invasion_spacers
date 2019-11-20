extends Area2D

export var movement_margin = 100
export var speed = 200
export var health = 100
export var bullet_damage = 20
var velocityV2 = Vector2()
var screen_size

export (PackedScene) var bullet
export (PackedScene) var explosion

signal enemy_dead

onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")
onready var movement_timer = get_node("movement_timer")
onready var health_bar = get_node("health_bar")
onready var death_timer = get_node("death_timer")
onready var sprite = get_node("Sprite")
onready var collision_shape = get_node("CollisionShape2D")


var movement_switch_chance
var invadersLeft
var targeting_limit

func _ready():
	velocityV2.x = speed
	add_to_group("enemies")
	health_bar.value = health
	screen_size = get_viewport_rect().size
	set_difficulty(Global.level)
	
func set_difficulty(level):
	print("\n Level: ", level)
	
	gun_timer.wait_time = 1.5
	gun_timer.wait_time = clamp(gun_timer.wait_time - (0.15 * level) , 0.3, 2)
	print("Gun timer: ", gun_timer.wait_time)
	
	movement_switch_chance = 0
	movement_switch_chance = clamp(movement_switch_chance + (0.1 * level), 0, 0.5) 
	print("Movement switch chance: ", movement_switch_chance)
	
	targeting_limit = 1
	targeting_limit = clamp(targeting_limit + (0.3 * level), 0, 3)
	print("Targeting limit: ", targeting_limit)
	
	speed *= 7 * level
	print("Speed: ", speed)
	

func shoot():
	gun_timer.start()
	var b = bullet.instance()
	bullet_container.add_child(b)
	
	var targetPosition = null
	if (invadersLeft <= targeting_limit): 
		targetPosition = get_parent().get_node("InvaderContainer").get_children()[rand_range(0, invadersLeft-1)].position
	b.start_at(get_node("muzzle").global_position, targetPosition)

func _physics_process(delta):
	if death_timer.is_stopped():
		position = position + velocityV2 * delta
		invadersLeft = get_parent().get_node("InvaderContainer").get_child_count()
		if invadersLeft > 0:
			if gun_timer.time_left == 0:
				shoot()
			if movement_timer.time_left == 0:
				chance_switch(movement_switch_chance)
	
	if position.x > screen_size.x - movement_margin:
		switch_direction()
	if position.x < movement_margin:
		switch_direction()
		
func switch_direction():
	velocityV2.x *= -1
	
	
func chance_switch(chance):
	movement_timer.start()
	var x = rand_range(0,1)
	if x <= chance: switch_direction()		
				
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
		collision_shape.scale = Vector2(0,0)
		expl.play()
		death_timer.start()
		if invadersLeft > 0:
			emit_signal("enemy_dead")
		
func _on_death_timer_timeout():
	queue_free()



