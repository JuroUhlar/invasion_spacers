extends Area2D

var velocityV2 = Vector2()
export var speed = 450
export (PackedScene) var explosion

onready var sound_player = get_node("AudioStreamPlayer2D")

func _ready():
	velocityV2.y = -speed
	add_to_group("bullets")
	add_to_group("player_bullets")

func _physics_process(delta):
	position = position + velocityV2 * delta

func start_at(pos, invaderN):
	position = pos
	velocityV2.y = -speed
	sound_player.pitch_scale = 0.3 * invaderN
	sound_player.play()

func _on_lifetime_timeout():
	queue_free()

func _on_player_bullet_area_entered(area):
	if area.get_groups().has("enemies"):
		var expl = explosion.instance()
		get_parent().add_child(expl)
		expl.position = position
		expl.play()
		queue_free()

