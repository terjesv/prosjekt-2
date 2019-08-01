extends Area2D


func _on_NextLevelArea_body_entered(body):
	if body.is_in_group("character"):
		#Globals.play_song() *insert song, optionally volume in db*
		get_tree().change_scene("res://levels/skull_levels/Skull_level_2.tscn")
		Globals.play_song(Globals.main_menu_song)
