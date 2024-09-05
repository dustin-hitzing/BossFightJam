extends Node2D

@export var player : CharacterBody2D
@onready var icon: Sprite2D = $Icon
@export var orbit_radius: float = 500.0
@export var projectile_scene: PackedScene
@export var projectile_speed: float = 600.0
@export var fire_rate: float = 0.5

var time_since_last_shot: float = 0.0

func _process(delta: float) -> void:
	if player:
		# Get the global position of the mouse
		var mouse_position = get_global_mouse_position()

		# Calculate the direction from the character to the mouse
		var direction = (mouse_position - player.global_position).normalized()

		# Calculate the new position for the indicator
		var indicator_position = player.global_position + direction * orbit_radius

		# Set the position of the indicator
		icon.global_position = indicator_position

		# Accumulate time since last shot
		time_since_last_shot += delta

		# Check if the fire button is pressed and enough time has passed
		if Input.is_action_pressed("shoot"):
			if time_since_last_shot >= fire_rate:
				shoot_projectile(indicator_position, direction)
				time_since_last_shot = 0.0
			else:
				print("Waiting to shoot, not enough time has passed.")
		else:
			print("Shoot action not detected.")

func shoot_projectile(start_position: Vector2, direction: Vector2) -> void:
	# Instance a new projectile
	var projectile = projectile_scene.instantiate() as Area2D

	# Check if the projectile was successfully instantiated
	if projectile == null:
		print("Failed to instance projectile.")
		return

	# Set the initial position of the projectile to the reticle's position
	projectile.global_position = start_position

	# Rotate the projectile to face the direction it will travel
	projectile.rotation = direction.angle()

	# Add the projectile to the scene
	get_tree().current_scene.add_child(projectile)

	# Set the velocity of the projectile
	var velocity = direction * projectile_speed

	projectile.velocity = velocity
