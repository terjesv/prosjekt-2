extends Control

func _on_Ok_pressed():
	if Globals.data_sharing_mode == "data":
		get_tree().change_scene('res://menus/questionnaire/PostQuestionnaire.tscn')
	else:
		get_tree().change_scene("res://menus/TitleScreen.tscn")