extends Control


func _on_MyPhone_pressed():
	# Checks if the game is running on android, else OS.get_unique_ID() results in an error 
	if Engine.has_singleton("AndroidPermissions"):
		var id = OS.get_unique_id().sha256_text()
		Globals.player_id = id
	get_tree().change_scene('res://menus/questionnaire/PreQuestionnaire.tscn')
		
func _on_Borrow_pressed():
	get_tree().change_scene('res://menus/Username.tscn')

func _on_Back_pressed():
	get_tree().change_scene('res://menus/Mode.tscn')
