extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if not Globals.game_over:
		Globals.win = true
		Globals.player_stop_slide = true
		$"AudioStreamPlayer2D".play()
		anim.play("down")

func _ready() -> void:
	anim.play("idle")


func _on_audio_stream_player_2d_finished() -> void:
	if Globals.win:
		if Globals.currentLevel == Globals.maxLevels:
			get_tree().change_scene_to_file("res://end.tscn")
		else:
			#get_tree().change_scene_to_file("res://Levels/level2.tscn")
			Globals.currentLevel += 1
			get_tree().change_scene_to_file("res://Levels/level"+str(Globals.currentLevel)+".tscn")
