extends Node2D

var player
var dialog_text
var button
var dialog
var interface

var dialogArrayHappy = [
	"Hello, stranger! Enjoying the countryside, eh?",
	"What - you need a place to spend the night?",
	"Well, I don’t got a lot of room, but I’ll spread some rags on the floor for you.",
	"I’ll meet you inside, just gotta finish up out here."
	]
var dialogArrayMedium = [
	"So, you want a place to sleep, eh?",
	"Well, I know who you are. You just escaped from prison.",
	"How I know that?",
	"I got the information off that skeleton guy. Good to keep an eye out, y’know?",
	"Anyway, you seem okay. Tell you what, you can sleep in the barn - just don’t mess with my animals!",
	"Now, go hide before anyone sees you."
	]
var dialogArrayPissed = [
	"You want a place to sleep?",
	"No way! I’ve been told who you are. You just escaped prison! You’ll get me in trouble, you will.",
	"How I know that?",
	"I got the information off that skeleton guy. Good to keep an eye on folks lurking on my land, y’know?",
	"Now, get moving."
	]
var dialogIndex
var currentDialogArray

var status

var encountered

func _ready():
	player = get_node("../Player")
	dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $PopupDialog/PopupDialog
	button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = get_node("../Player/Interface/Control")
	
	dialog.hide()
	
	dialogIndex = 0
	
	status = Globals.get_upgrade(1)
	
	encountered = false
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		if not encountered:
			if not status[0]:
				currentDialogArray = dialogArrayHappy
			elif status[1]:
				currentDialogArray = dialogArrayPissed
				Globals.health_penalty += 4
			else:
				currentDialogArray = dialogArrayMedium
				Globals.health_penalty += 2
			encountered = true
		dialog.show()
		interface.hide()
		if dialogIndex == 0:
			dialog_text.set_text(currentDialogArray[dialogIndex])
	


func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		player.setDialogueSource(null)


func converse():
	pass

func _on_NextButton_pressed():
	dialogIndex += 1
	if dialogIndex >= currentDialogArray.size():
		if currentDialogArray == dialogArrayPissed:
			dialog.hide()
			interface.show()
		else:
			var fade = load("res://levels/common/BlackScreen.tscn").instance()
			fade.next = "res://levels/skull_levels/Skull_level_2.tscn"
			self.add_child(fade)
			
	else:
		dialog_text.set_text(currentDialogArray[dialogIndex])
