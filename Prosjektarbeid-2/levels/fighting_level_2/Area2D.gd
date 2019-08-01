#Detta er placeholder for goto-next-level-thing.
extends Node

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene("res://levels/city/city.tscn")
