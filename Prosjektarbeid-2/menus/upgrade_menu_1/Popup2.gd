extends MarginContainer

onready var text = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var confirm = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton
onready var back = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BackButton
var page = 1
#var scene = 1
var scene


func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/Button.hide()

func _on_BackButton_pressed():
	if page == 2:
		page -= 1
		text.text = "The phone state.\nAllows read only access to phone state, " \
				+ "including the phone number of the device, current cellular network information, " \
				+ "the status of any ongoing calls, " \
				+ "and a list of any PhoneAccounts registered on the device." \
				+ "\nThis is required for you to accept the update."
		$PanelContainer/MarginContainer/VBoxContainer/Button.hide()
		$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton.text = "NEXT"
	else:
		self.hide()

func _on_ConfirmButton_pressed():
	if page == 1:
		Globals.permissions.requestReadPhoneStatePermission()
	else:
		if $PanelContainer/MarginContainer/VBoxContainer/Button/TextureButton.pressed:
			Globals.permissions.requestReadCalendarPermission()
		else:
			scene.choices = [true, false]
			scene.activity += "| save off |"
			scene.scene_3.hide()
			scene.scene_5.show()
			scene.prev.hide()
			self.hide()
