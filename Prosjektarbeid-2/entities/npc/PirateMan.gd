extends Node2D

var player
var dialog_text
var button
var dialog
var interface

var dialogArray = [
	"Talk of the town is this skeleton figure that goes around buying and selling information.",
	"Now, me personally, I don’t partake. No one’s getting at my secret treasures, hehe...",
	"Hear there’s some good secrets to be gotten off of him if ye pay the price, though!"
	]
var dialogIndex

func _ready():
	player = get_node("../../Player")
	dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $PopupDialog/PopupDialog
	button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = get_node("../../Player/Interface/Control")
	
	$speech_bubble.hide()
	dialog.hide()
	
	dialogIndex = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("character") && dialogIndex == 0:
		$speech_bubble.show()
		player.setDialogueSource(self.get_path())
	


func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		$speech_bubble.hide()
		player.setDialogueSource(null)


func converse():
	dialog.show()
	interface.hide()
	$speech_bubble.hide()
	if dialogIndex == 0:
		dialog_text.set_text(dialogArray[dialogIndex])

func _on_NextButton_pressed():
	dialogIndex += 1
	if dialogIndex >= dialogArray.size():
		dialog.hide()
		interface.show()
	else:
		dialog_text.set_text(dialogArray[dialogIndex])
