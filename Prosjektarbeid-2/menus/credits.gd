extends Control

func _ready():
	
	Globals.play_song(Globals.credit_song, -10)


func _on_Button_pressed():
	Globals.music_player.stop()
	get_tree().change_scene('res://menus/TitleScreen.tscn')
