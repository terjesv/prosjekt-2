extends Area2D


func _on_NextLevel_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene("res://levels/skull_levels/Skull_level_1.tscn")
		#Globals.play_song(Globals.city_song, -17)
