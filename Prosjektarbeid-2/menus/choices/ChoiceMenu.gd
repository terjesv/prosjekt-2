extends MarginContainer

onready var PrivacyChoice = preload("res://menus/choices/PrivacyChoice.tscn")
onready var PrivacyInfo = preload("res://menus/choices/PrivacyInfo.tscn")
onready var PrivacySetting = preload("res://menus/choices/PrivacySettings.tscn")
onready var EndLevelSettings = preload("res://menus/choices/EndLevelSettings.tscn")
var level
var active_options
var end_level
var parent
var globals

func _ready():
	globals = get_tree().get_root().get_node("Globals")
	active_options = globals.get_all_upgrades()	
	
func open_choice_menu(parent):
	self.parent = parent
	var choice = PrivacyChoice.instance()
	choice.level = level
	choice.parent = self
	add_child(choice)
	
func open_settings_menu(parent):
	self.parent = parent
	end_level = true
	var settings = EndLevelSettings.instance()
	settings.level = level
	settings.parent = self
	settings.active = active_options
	add_child(settings)

func change_setting():
	var info = PrivacyInfo.instance()
	info.level = level
	info.parent = self
	add_child(info)
		
func show_setting(active, option):
	var setting = PrivacySetting.instance()
	setting.option = option
	setting.level = level
	setting.parent = self
	setting.active = active
	add_child(setting)
	
func save_setting(option, active):
	active_options[option] = active
	parent.save_choice(active)
	globals.set_upgrade(option, active)
	if end_level:
		open_settings_menu(parent)
	else:
		self.queue_free()

func save_activity(level, string):
	if end_level:
		globals.set_activity(1, level-1, string)
	else:
		globals.set_activity(0, level-1, string)
