extends StaticBody2D
class_name Key

signal collected

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("collected")
		$Sprite2D.visible = false
		$Area2D.queue_free()
		$CollisionShape2D.queue_free()
		$Sound.play()
		await $Sound.finished
		queue_free()
