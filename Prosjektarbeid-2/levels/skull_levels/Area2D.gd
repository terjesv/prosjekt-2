extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene("res://levels/fighting_level_3/Fighting_level_3.tscn")
