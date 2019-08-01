extends CanvasLayer

onready var number = $Control/HUD/HPContainer/Background/MarginContainer/HBoxContainer/Number
onready var bar = $Control/HUD/HPContainer/TextureProgress
onready var mute_music_button = $Control/PauseMenu/PanelContainer/MarginContainer/VBoxContainer/MuteMusic
onready var mute_sound_button = $Control/PauseMenu/PanelContainer/MarginContainer/VBoxContainer/MuteSound
onready var pause_menu = $Control/PauseMenu
onready var character_sound_player = get_node("../AudioStreamPlayer")
var paused
var current_scene


func _ready():
	pause_menu.hide()
	paused = false
	music_setup()

func music_setup():
	# If the interface has loaded before, the singleton already has
	# a reference to the mute buttons and should instead update them.
	if !Globals.music_button && !Globals.sound_button:
		Globals.music_button = mute_music_button
		Globals.sound_button = mute_sound_button
	else:
		mute_music_button.pressed = !Globals.muted[0]
		mute_sound_button.pressed = !Globals.muted[1]
	
	# Music muted in option screen
	if Globals.muted[0]:
		mute_music_button.pressed = false
	# The sound player is not in the singleton and needs to be set explicitly
	# on each scene change
	if Globals.muted[1]:
		character_sound_player.set_volume_db(-80)
		mute_sound_button.pressed = false

func _on_KinematicBody2D_health_changed(player_health):
	bar.value = player_health
	number.text = str(player_health)
	
func set_health_bar(max_health):
	bar.max_value = max_health
	$Control/HUD/HPContainer/Background/MarginContainer/HBoxContainer/Number.set_text(str(max_health))
	if max_health > 10:
		bar.texture_under = preload("res://ui/interface/lifebar_bg_upgrade_half.png")
		bar.texture_progress = preload("res://ui/interface/lifebar_fill_upgrade_half.png")
	else:
		bar.texture_under = preload("res://ui/interface/lifebar_bg_half.png")
		bar.texture_progress = preload("res://ui/interface/lifebar_fill_half.png")

func _on_PauseButton_pressed():
	if paused:
		get_tree().paused = false
		paused = false
		pause_menu.hide()
	else:
		get_tree().paused = true
		paused = true
		pause_menu.show()

func _on_ResumeButton_pressed():
	get_tree().paused = false
	paused = false
	pause_menu.hide()


func _on_QuitButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://menus/TitleScreen.tscn")


func _on_MuteMusic_pressed():
	# Lets the singleton update the mute music button state, and play/pause
	Globals.muted[0] = !Globals.muted[0]
	Globals.music_player._set_playing(!Globals.music_player.is_playing())


func _on_MuteSound_pressed():
	# Update singleton state
	Globals.muted[1] = !Globals.muted[1]
	# Since the sound player doesn't play continously its volume has to be set
	# instead of stopped.
	if character_sound_player.get_volume_db() == 0:
		character_sound_player.set_volume_db(-80)
	else:
		character_sound_player.set_volume_db(0)


func _on_SkipStage_pressed():
	current_scene = get_tree().get_current_scene().get_name()
	
	match current_scene:
		
		"prison":
			get_tree().change_scene("res://levels/skull_levels/Skull_level_1.tscn")
		
		"Fighting_level_1":
			get_tree().change_scene("res://levels/farm/farm.tscn")
		
		"Fighting_level_2":
			get_tree().change_scene("res://levels/city/city.tscn")
			
		"Fighting_level_3":
			get_tree().change_scene("res://levels/ending_levels/boss_level.tscn")
		
		"Boss_level":
			get_tree().change_scene("res://levels/ending_levels/ending_level.tscn")
		
	get_tree().paused = false
	paused = false
	pause_menu.hide()	
