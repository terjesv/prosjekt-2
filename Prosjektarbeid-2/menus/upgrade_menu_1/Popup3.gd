extends MarginContainer

onready var text = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var confirm = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton
onready var back = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BackButton
var page = 1
#var scene = 1
var scene


#func _ready():
#	if scene == 1:
#		text = "Welcome to the upgrade menu. Here you can exchange data for upgrades"
#	if scene == 2:
#		text = ""

func _on_BackButton_pressed():
	self.hide()

func _on_ConfirmButton_pressed():
	self.hide()
	# Go back to in-game