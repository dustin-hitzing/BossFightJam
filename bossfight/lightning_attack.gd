extends GPUParticles2D
class_name LightingAttack

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func attack() -> void:
	print("Lightning Attack was Created")
	scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1,1), 1)
	tween.tween_interval(2)
	#audio_stream_player_2d.play()
	tween.tween_property(self, "scale", Vector2(100,100), 4)
	print("Lightning Attack FINISHED")
	queue_free()
	pass
