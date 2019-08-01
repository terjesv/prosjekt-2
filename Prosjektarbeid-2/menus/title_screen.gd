extends Control

func _ready():
	if !Globals.music_player.is_playing():
		Globals.play_song(Globals.main_menu_song)


func _on_newgame_pressed():
	Globals.flush()
	get_tree().change_scene('res://menus/Mode.tscn')


func _on_Options_pressed():
	get_tree().change_scene('res://menus/Options.tscn')





func _on_Credits_pressed():
	get_tree().change_scene('res://menus/credits.tscn')


func _on_Tutorial_pressed():
	get_tree().change_scene('res://menus/tutorial/tutorial.tscn')
