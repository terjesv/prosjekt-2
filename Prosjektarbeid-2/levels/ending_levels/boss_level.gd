extends Node2D

onready var interface = $Player/Interface/Control
onready var button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
onready var dialog = $PopupDialog/PopupDialog
onready var dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
var index = 0
var d_seq

var text = {
		1: [
			"Haha, you thought you could escape?", 
			"Thanks to our skeletal friend we knew just when you would arrive" \
			+ "and had time to bring in reinforcements.",
			"Prepare to die!"
			],
		2: [
			"Hey, there! Welcome to the border crossing, have your toll on h-... Wait a moment!",
			"Aren't you that guy who escaped from prison? There's a fat bounty out on your head.",
			"Prepare to die!"
			]
		}


func _ready():
	Globals.play_song(Globals.boss_song)
	dialog.hide()
	$Enemies/soldier.set_physics_process(false)
	$Enemies/soldier2.set_physics_process(false)
	$Boss/minotaur/KinematicBody2D.damage_immunity = true

func _on_EnterBoss_body_entered(body):
	if body.is_in_group("character"):
		$Platforms/Restrict.set_position(Vector2(0,-150))
		#when you have beat the boss, use this to allow progress
		#$Platforms/Allow.set_position(Vector2(0,100))
		$Player/KinematicBody2D/Camera2D.limit_left = 80
		run_dialog()
		$EnterBoss.queue_free()


func _on_NextArea_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene("res://levels/ending_levels/ending_level.tscn")
		
func run_dialog():
	if Globals.get_upgrade(3)[0]:
		d_seq = 1
	else:
		d_seq = 2
	interface.hide()
	dialog_text.set_text(text[d_seq][index])
	dialog.show()
	
func _on_NextButton_pressed():
	index += 1
	if index < text[d_seq].size():
		dialog_text.set_text(text[d_seq][index])
	else:
		dialog.hide()
		interface.show()
		start_fight()

func start_fight():
	$Boss/minotaur/KinematicBody2D.damage_immunity = false
	$Boss/minotaur/KinematicBody2D.talked_yet = true
	$Boss/minotaur/KinematicBody2D.speed = $Boss/minotaur/KinematicBody2D.max_speed
	if d_seq == 1:
		$Enemies/soldier.position.y = 207
		$Enemies/soldier2.position.y = 207
		$Enemies/soldier.set_physics_process(true)
		$Enemies/soldier2.set_physics_process(true)
		$Enemies/soldier.visible = true
		$Enemies/soldier2.visible = true
		
