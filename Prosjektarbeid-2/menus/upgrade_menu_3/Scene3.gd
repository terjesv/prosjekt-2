extends VBoxContainer

func set_text(setting):
	if setting == 0:
		$Label.text = "Access location"
		$RichTextLabel.text = "Allows the application to access the device's location\n"\
		+ "This is required to recieve the upgrade."
	elif setting == 1:
		$Label.text = "Access camera"
		$RichTextLabel.text = "Allows the application access to the camera"\
		+ "This is not required to recieve the upgrade."
	else:
		$Label.text = "Record audio"
		$RichTextLabel.text = "Gives the application access to record audio"\
		+ "This is not required to recieve the upgrade."