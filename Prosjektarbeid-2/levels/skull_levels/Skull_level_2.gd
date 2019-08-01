extends Node2D

var level = 2

onready var dialog = $PopupDialog/PopupDialog
onready var dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
onready var interface = $Player/Interface/Control

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_left = 0
	$Player/KinematicBody2D/Camera2D.limit_right = 650
	$Player/KinematicBody2D/Camera2D.limit_bottom = 450
	$Player/KinematicBody2D/Camera2D.limit_top = -2
	$Skull.scale = Vector2(-1, 1)
	Globals.play_song(Globals.skull_song)
	
	if Globals.get_upgrade(1)[0]:
		dialog_text.text = "Yaaaawn, I haven't gotten much sleep...\nI feel really tired and weak."
	else:
		dialog_text.text = "Mmmm, I slept so well.\nI feel revitalized."

func _on_Area2D_body_entered(body):
	if body.is_in_group("character") && $Skull.encountered:
		get_tree().change_scene("res://levels/fighting_level_2/Fighting_level_2.tscn")

func _on_NextButton_pressed():
	dialog.hide()
	interface.show()
