extends StaticBody2D

func hit(_dam, _kb):
	$Break.play()
	$CollisionShape2D.disabled = true
	$Bush.visible = false
	

func _on_break_finished():
	queue_free()
