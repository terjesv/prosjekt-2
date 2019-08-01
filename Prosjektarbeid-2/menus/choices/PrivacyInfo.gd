extends Container

onready var content = preload("res://menus/choices/MenuText.gd")
onready var header = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/Header
onready var text = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/ChoiceText
var level
var parent

func _ready():
	header.set_text(content.INFO[level-1][0])
	text.set_text(content.INFO[level-1][1])

func _on_ContinueButton_pressed():
	self.queue_free()
	parent.show_setting(true, level)
