extends Container

onready var popup = $MarginContainer/PanelContainer/Popup
onready var scene_1 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene1
onready var scene_2 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene2
onready var scene_3 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene3
onready var all_settings = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/AllSettings
onready var setting = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Setting

var choices = [true, true, true]
var finished = [true, false, false]
var current_setting
var cont = false

onready var toggle = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Setting/HBoxContainer/TextureButton
onready var back = $MarginContainer/PanelContainer/VBoxContainer/PanelContainer/BackButton
var activity = ""

var skull

func _ready():
	Globals.upgrade_menu = self
	popup.hide()
	scene_2.hide()
	scene_3.hide()
	all_settings.hide()
	back.hide()
	
func request_callback(request_code, permissions, granted):
	if scene_2.visible:
		if request_code == 3 and granted:
			Globals.permissions.requestReadCallLogPermission()
		elif request_code == 11:
			if !granted:
				choices[1] = false
			Globals.permissions.requestReadSmsPermission()
		elif request_code == 19:
			if !granted:
				choices[2] = false
			scene_2.hide()
			scene_3.show()
			back.hide()
	elif all_settings.visible:
		if request_code == 3 and not granted:
			pass
		else:
			if request_code == 11 and not granted:
				choices[1] = false
			elif request_code == 19 and not granted:
				choices[2] = false
	
			if not finished[1]:
				finished[1] = true
				Globals.permissions.requestReadCallLogPermission()
			elif not finished[2]:
				finished[2] = true
				Globals.permissions.requestReadSmsPermission()
			else:
				all_settings.hide()
				scene_3.show()
				back.hide()

func _on_ExitButton_pressed():
	activity += "| exit |"
	popup.scene = self
	popup.show()
	
func save_changes():
	Globals.set_upgrade(2, choices)
	Globals.set_activity(1, activity)
	skull.save_choice(choices[0])
	self.queue_free()

#SCENE1____________________________________________________________________
func _on_Scene1Button_pressed():
	activity += "| continue |"
	scene_1.hide()
	scene_2.show()
	back.show()

#SCENE2____________________________________________________________________
func _on_ManageButton_pressed():
	activity += "| manage |"
	scene_2.hide()
	all_settings.show()

func _on_AgreeButton_pressed():
	activity += "| agree |"
	Globals.permissions.requestReadContactsPermission()

#ALLSETTINGS____________________________________________________________
func _on_SaveButton_pressed():
	#continue on all setting screen
	activity += "| save |"
	Globals.permissions.requestReadContactsPermission()

func _on_LinkButton_pressed():
	activity += "| edit1 |"
	all_settings.hide()
	current_setting = 0
	toggle.hide()
	setting.set_text(1)
	setting.show()

func _on_LinkButton2_pressed():
	activity += "| edit2 |"
	all_settings.hide()
	current_setting = 1
	toggle.show()
	if choices[1]:
		toggle.pressed = true
	else:
		toggle.pressed = false
	setting.set_text(2)
	setting.show()

func _on_LinkButton3_pressed():
	activity += "| edit3 |"
	all_settings.hide()
	current_setting = 2
	toggle.show()
	if choices[2]:
		toggle.pressed = true
	else:
		toggle.pressed = false
	setting.set_text(3)
	setting.show()

#SCENE3__________________________________________________________________
func _on_ReturnButton_pressed():
	save_changes()
	self.queue_free()

#SETTING_________________________________________________________________
func _on_Button_pressed():
	#Når man trykker save inne på en setting
	if toggle.is_pressed():
		activity += "| toggle on |"
		choices[current_setting] = true
		finished[current_setting] = false
		setting.hide()
		all_settings.show()
	else:
		activity += "| toggle off |"
		choices[current_setting] = false
		finished[current_setting] = true
		setting.hide()
		all_settings.show()
	if toggle.disabled:
		toggle.disabled = false


func _on_BackButton_pressed():
	if scene_2.visible:
		scene_2.hide()
		scene_1.show()
		back.hide()
	elif all_settings.visible:
		all_settings.hide()
		scene_2.show()
	elif scene_3.visible:
		scene_3.hide()
		scene_2.show()
	elif setting.visible:
		setting.hide()
		all_settings.show()