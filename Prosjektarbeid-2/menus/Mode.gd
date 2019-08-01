extends Control





func _on_fun_pressed():
	Globals.data_sharing_mode = "fun"
	get_tree().change_scene('res://levels/prison/prison.tscn')


func _on_data_pressed():
	Globals.data_sharing_mode = "data"
	get_tree().change_scene('res://menus/phoneOwner.tscn')


func _on_Back_pressed():
	get_tree().change_scene('res://menus/TitleScreen.tscn')
