extends Area2D

var velocityV2 = Vector2()
export var speed = 400


func _ready():
	velocityV2.y = speed
	add_to_group("bullets")

func _physics_process(delta):
	position = position + velocityV2 * delta

func start_at(pos):
	position = pos
	velocityV2.y = speed




func _on_lifetime_timeout():
	queue_free()


func _on_player_bullet_area_entered(area):
	if area.get_groups().has("invaders"):
		queue_free()
		print(area.name)
