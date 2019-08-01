extends VBoxContainer

func set_text(setting):
	if setting == 0:
		$RichTextLabel.text = "Access location\n"\
		+ "This is required. If you accept you will not be able to go back to reject the upgrade"
	elif setting == 1:
		$RichTextLabel.text = "Access camera"
	else:
		$RichTextLabel.text = "Record audio"