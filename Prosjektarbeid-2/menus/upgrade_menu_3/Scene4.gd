extends VBoxContainer

func set_text(setting, active):
	if setting == 0:
		$HBoxContainer/RichTextLabel.text = "Access location (this is required)\n"\
		+ "If you accept you will not be able to go back to reject the upgrade"
		$HBoxContainer/TextureButton.hide()
	elif setting == 1:
		$HBoxContainer/RichTextLabel.text = "Access camera\n This permission is not required"
		$HBoxContainer/TextureButton.show()
		$HBoxContainer/TextureButton.disabled = false
		$HBoxContainer/TextureButton.pressed = active
	else:
		$HBoxContainer/RichTextLabel.text = "Access audio recorder\n This permission is not required"
		$HBoxContainer/TextureButton.show()
		$HBoxContainer/TextureButton.disabled = false
		$HBoxContainer/TextureButton.pressed = active