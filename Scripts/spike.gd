extends StaticBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	Globals.player_can_move = false
	Globals.game_over = true
	body.get_node("AnimatedSprite2D").play("death")
	$"AudioStreamPlayer2D".play()

func _on_audio_stream_player_2d_finished() -> void:
	$"ExtraWaitout".start()

func _on_extra_waitout_timeout() -> void:
	Globals.player_can_move = true
	get_tree().reload_current_scene()
