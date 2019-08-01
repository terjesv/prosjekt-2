extends Node2D

onready var character = get_node("Player/KinematicBody2D")
onready var camera = get_node("Player/KinematicBody2D/Camera2D")

var visibility = 0
var level = 1

func _ready():
	$Skull.hide()
	camera.limit_left = 0
	camera.limit_right = 1100
	Globals.play_song(Globals.skull_song)
	



func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		if $Skull.encountered:
			get_tree().change_scene("res://levels/fighting_level_1/Fighting_level_1.tscn")
		else:
			$Skull.position.y = 128
			$Skull.show()
