extends MarginContainer

onready var text = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var confirm = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton
onready var back = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BackButton
var page = 1
var scene

func _on_BackButton_pressed():
	self.hide()

func _on_ConfirmButton_pressed():
	if page == 1:
		page += 1
		text.text = "This will reduce your chances of reaching the border"
		confirm.text = "I DON'T CARE"
	elif page == 2:
		page += 1
		text.text = "Absolutely sure?"
		confirm.text = "YES"
	else:
		scene.choices = [false, false, false]
		scene.save_changes()
