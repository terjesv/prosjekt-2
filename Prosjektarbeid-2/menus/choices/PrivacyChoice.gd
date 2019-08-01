extends Container

onready var content = preload("res://menus/choices/MenuText.gd")
onready var header = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/Header
onready var text = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/ChoiceText
var level
var parent

func _ready():
	header.set_text(content.CHOICE[level-1][0])
	text.set_text(content.CHOICE[level-1][1])

func _on_ManageButton_pressed():
	parent.save_activity(level, "manage_settings")
	self.queue_free()
	parent.change_setting()

func _on_AcceptButton_pressed():
	parent.save_activity(level, "accept_upgrade")
	parent.save_setting(level, true)
