extends Area2D

var velocityV2 = Vector2()
export var speed = 400
export (PackedScene) var explosion


func _ready():
	velocityV2.y = speed
	add_to_group("bullets")
	add_to_group("enemy_bullets")

func _physics_process(delta):
	position = position + velocityV2 * delta

func start_at(pos, targetPos = null):
	position = pos
	
	if (targetPos): 
		velocityV2 = (targetPos - position).normalized() * speed
		self.look_at(targetPos)
		rotation -= deg2rad(90)
	else:
		velocityV2.y = speed
		

func _on_lifetime_timeout():
	queue_free()


func _on_player_bullet_area_entered(area):
	if area.get_groups().has("invaders"):
		var expl = explosion.instance()
		get_parent().add_child(expl)
		expl.position = position
		expl.play()
		queue_free()
