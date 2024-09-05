extends Area2D

var velocity: Vector2
@export var damage: float = 1.0

func _process(delta: float) -> void:
	# Move the projectile
	position += velocity * delta
	print("projectile was created")
	# Optional: queue_free() the projectile if it goes off-screen
	await get_tree().create_timer(5).timeout
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("boss"):
		if area.has_method("take_damage"):
			area.take_damage(damage)
			queue_free()
		pass
