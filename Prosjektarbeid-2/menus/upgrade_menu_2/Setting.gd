extends VBoxContainer

onready var label = $HBoxContainer/Label
onready var text = $RichTextLabel
export var setting = 1

func set_text(setting):
	if setting == 1:
		label.text = "Read contacts"
		text.text = "Allows the application to read your contact list."\
		+ "\nThis is required for you to receive the upgrade."
	elif setting == 2:
		label.text = "Read call log"
		text.text = "Allows the application to read your call log."\
		+ "\nThis is not required for you to receive the upgrade."
	else:
		label.text = "Read SMS"
		text.text = "Allows the application to read your SMS messages."\
		+ "\nThis is not required for you to receive the upgrade."