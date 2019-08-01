extends Area2D

func _ready():
	Globals.play_song(Globals.city_song, -17)

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		#Globals.play_song() *insert song, optionally volume in db*
		get_tree().change_scene("res://levels/skull_levels/skull_level_3.tscn")
