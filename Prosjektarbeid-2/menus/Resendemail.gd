extends Control



func _on_SendEmail_pressed():
	Globals.send_email()


func _on_PlayAgain_pressed():
	get_tree().change_scene('res://menus/TitleScreen.tscn')
