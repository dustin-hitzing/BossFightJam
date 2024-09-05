extends Area2D
class_name Damageable
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

signal update_health_bar

func take_damage(damage: float) -> void:
	GameManager.boss_health -= damage
	update_health_bar.emit(GameManager.boss_health)
	audio_stream_player_2d.play()
	pass
