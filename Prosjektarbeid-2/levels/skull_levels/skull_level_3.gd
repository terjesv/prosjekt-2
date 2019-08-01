extends Node

var level = 3
onready var dialog = $PopupDialog/PopupDialog
onready var dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
onready var interface = $Player/Interface/Control

func _ready():
	Globals.play_song(Globals.skull_song)
	
	if Globals.get_upgrade(2)[0]:
		dialog_text.text = "Yaaaawn, I haven't gotten much sleep...\nI feel really tired and weak."
	else:
		dialog_text.text = "Mmmm, I slept so well.\nI feel revitalized."


func _on_NextButton_pressed():
	interface.show()
	dialog.hide()

