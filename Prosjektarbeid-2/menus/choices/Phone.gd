extends Node

onready var PrivacyChoice = preload("res://menus/choices/PrivacyChoice.tscn")
onready var PrivacyInfo = preload("res://menus/choices/PrivacyInfo.tscn")
onready var PrivacySetting = preload("res://menus/choices/PrivacySettings.tscn")
onready var EndLevelSettings = preload("res://menus/choices/EndLevelSettings.tscn")
onready var display = $Container/Sprite/Container
var level
var active_options = [false, false, false]
var scale = 0.01
var opening = true
var end_level

onready var sprite = $Container/Sprite

func _process(delta):
	if opening:
		if scale < 0.2:
			sprite.set_scale(Vector2(scale, scale))
			scale += 0.01
	else:
		if scale > 0:
			sprite.set_scale(Vector2(scale, scale))
			scale -= 0.01
		else:
			self.queue_free()

func _ready():
	sprite.set_scale(Vector2(0, 0))
	
func choice():
	var choice = PrivacyChoice.instance()
	choice.level = level
	choice.parent = self
	display.add_child(choice)
	
func settings_menu(active):
	active_options = active
	var settings = EndLevelSettings.instance()
	settings.level = level
	settings.parent = self
	settings.active = active_options
	display.add_chld(settings)

func change_setting():
	var info = PrivacyInfo.instance()
	info.level = level
	info.parent = self
	display.add_child(info)
		
func show_setting(active, level):
	var setting = PrivacySetting.instance()
	setting.level = level
	setting.parent = self
	setting.active = active
	display.add_child(setting)
	
func save_setting(option, active):
	#TODO add armor to player
	if active:
		active_options[option-1] = true
	else:
		active_options[option-1] = false
	if end_level:
		settings_menu(active_options)
	else:
		opening = false