extends Node2D

var max_depth = 1200

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_left = -80
	$Player/KinematicBody2D/Camera2D.limit_right = 2200
	Globals.play_song(Globals.fighting_song)


func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene("res://levels/farm/farm.tscn")