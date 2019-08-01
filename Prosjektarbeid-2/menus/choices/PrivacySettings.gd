extends Container

onready var content = preload("res://menus/choices/MenuText.gd")
onready var setting = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Setting
onready var button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
onready var popup = $PanelContainer/VBoxContainer/MarginContainer/PopupPanel
var active
var option
var parent
var level

func _ready():
	popup.hide()
	setting.set_text(content.SETTING[level-1])
	button.pressed = active


func _on_SaveButton_pressed():
	if active:
		parent.save_activity(level, "save_on")
		parent.save_setting(option, active)
	else:
		parent.save_activity(level, "save_off")
		popup.show()
	
func _on_Button_toggled(button_pressed):
	if active:
		active = false
		parent.save_activity(level, "switch_off")
	else:
		active = true
		parent.save_activity(level, "switch_on")

func _on_YesButton_pressed():
	popup.hide()
	parent.save_activity(level, "confirm_off")
	parent.save_setting(option, active)


func _on_NoButton_pressed():
	parent.save_activity(level, "decline_off")
	popup.hide()

