extends Area2D

export var movement_margin = 100
export var speed = 200
export var health = 100
var velocityV2 = Vector2()
var screen_size

func _ready():
	velocityV2.x = speed
	add_to_group("enemies")
	screen_size = get_viewport_rect().size
	

func _physics_process(delta):
	position = position + velocityV2 * delta
	
	if position.x > screen_size.x - movement_margin:
		velocityV2.x = -speed
	if position.x < movement_margin:
		velocityV2.x = speed

func _on_Enemy_area_entered(area):
	if area.get_groups().has("bullets"):
		health -= 20
		print(area.name)
		if health <= 0:
			queue_free()
