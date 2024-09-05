extends ProgressBar

@export var area_2d: Damageable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = GameManager.boss_health
	area_2d.update_health_bar.connect(update_health_bar)
	pass # Replace with function body.


func update_health_bar(health: float) -> void:
	value = health
	pass
