extends Node

var max_depth = 2000
var tunnel = false

func _ready():
	if not Globals.get_upgrade(3)[0]:
		tunnel = true
		$Player.position += Vector2(100, 310)
	Globals.play_song(Globals.fighting_song)

func _process(delta):
	if tunnel:
		if $Player/KinematicBody2D.position.x > 1900:
			$Player/KinematicBody2D/Camera2D.limit_bottom = 810
		else:
			$Player/KinematicBody2D/Camera2D.limit_bottom = 920

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene('res://levels/ending_levels/boss_level.tscn')
