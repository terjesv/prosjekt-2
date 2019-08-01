extends Node2D

var dialog_text
var button
var dialog
var interface

var dialogArray = [
	"!!",
	"Did the prison wall explode?",
	"Maybe I can escape by getting across the border…",
	"Better get to my parents in the city - they should be able to help me."
	]
var dialogIndex = 0


func _ready():
	dialog_text = $IntroText/PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $IntroText/PopupDialog/PopupDialog
	button = $IntroText/PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = $Player/Interface/Control
	
	if !Globals.music_player.is_playing():
		Globals.play_song(Globals.main_menu_song)
	
	dialog.hide()
	button.text = "Next"
	interface.hide()

func _on_ExplosionEnd_timeout():
	dialog.show()
	dialog_text.set_text(dialogArray[dialogIndex])


func _on_NextButton_pressed():
	dialogIndex += 1
	if dialogIndex >= dialogArray.size():
		dialog.hide()
		interface.show()
	else:
		dialog_text.set_text(dialogArray[dialogIndex])
