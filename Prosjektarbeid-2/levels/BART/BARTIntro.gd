extends Node

func _ready():
	get_tree().get_root().get_node("Globals").music_player.stop()

func _on_NextButton_pressed():
	get_tree().change_scene("levels/BART/BART.tscn")
