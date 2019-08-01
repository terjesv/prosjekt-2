extends Control

onready var mute_music = $CenterContainer/VBoxContainer/MuteMusic
onready var mute_sound = $CenterContainer/VBoxContainer/MuteSound

func _ready():
	mute_music.pressed = !Globals.muted[0]
	mute_sound.pressed = !Globals.muted[1]

#continue and options are inhereted scenes from newgame

func _on_Button_pressed():
	get_tree().change_scene('res://menus/TitleScreen.tscn')


func _on_MuteMusic_pressed():
	# Lets the singleton update the mute music button state, and play/pause
	Globals.muted[0] = !Globals.muted[0]
	Globals.music_player._set_playing(!Globals.music_player.is_playing())


func _on_MuteSound_pressed():
	Globals.muted[1] = !Globals.muted[1]
