extends Node2D

var dialog_text
var button
var dialog
var interface

func _ready():
	dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $PopupDialog/PopupDialog
	button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = $Player/Interface/Control
	Globals.play_song(Globals.ending_song)
	
	interface.hide()
	dialog.show()
	dialog_text.set_text("Phew, I actually managed it!")

func _on_EndArea_body_entered(body):
	if body.is_in_group("character"):
		Globals.music_player.stop()
		get_tree().change_scene("res://menus/EndingScreen.tscn")


func _on_NextButton_pressed():
	dialog.hide()
	interface.show()
