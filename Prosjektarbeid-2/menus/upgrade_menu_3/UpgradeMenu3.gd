extends Container

onready var popup = $MarginContainer/PanelContainer/Popup
onready var scene1 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene1
onready var scene2 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene2
onready var scene3 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene3
onready var scene4 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene4
onready var scene5 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene5

onready var prev = $MarginContainer/PanelContainer/VBoxContainer/PanelContainer/PrevButton

var choices = [true, true, true]
var current_setting = 0

var activity = ""

var skull

func _ready():
	Globals.upgrade_menu = self
	popup.hide()
	scene2.hide()
	scene3.hide()
	scene4.hide()
	scene5.hide()
	prev.hide()
	
func request_callback(request_code, permissions, granted):
	if request_code != 6 and !granted:
		choices[current_setting] = false
	
	if scene2.visible:
		if current_setting == 0 and request_code == 6 and granted:
			current_setting += 1
			scene2.set_text(current_setting)
			prev.hide()
			
		if current_setting == 1 and request_code == 2:
			current_setting += 1
			scene2.set_text(current_setting)
			
		if current_setting == 2 and request_code == 8:
			scene2.hide()
			scene5.show()
			prev.hide()
	elif scene4.visible:
		if current_setting == 0 and request_code == 6 and granted:
			current_setting += 1
			scene2.set_text(current_setting)
			scene4.hide()
			scene2.show()
			prev.hide()
			
		if current_setting == 1 and request_code == 2:
			current_setting += 1
			scene2.set_text(current_setting)
			scene4.hide()
			scene2.show()
			
		if current_setting == 2 and request_code == 8:
			scene4.hide()
			scene5.show()
			prev.hide()

func _on_ExitButton_pressed():
	activity += "| exit |"
	popup.scene = self
	popup.show()
	
func save_changes():
	Globals.set_upgrade(3, choices)
	Globals.set_activity(2, activity)
	skull.save_choice(choices[0])
	self.queue_free()

func _on_Scene1Continue_pressed():
	activity += "| continue |"
	prev.show()
	scene1.hide()
	scene2.set_text(current_setting)
	scene2.show()

func _on_AgreeButton_pressed():
	activity += "| agree |"
	if current_setting < 2:
		if current_setting == 0:
			Globals.permissions.requestAccessFineLocationPermission()
		else:
			Globals.permissions.requestCameraPermission()
	else:
		Globals.permissions.requestRecordAudioPermission()


func _on_InfoButton_pressed():
	activity += "| more info |"
	scene2.hide()
	scene3.set_text(current_setting)
	scene3.show()

func _on_BackButton_pressed():
	activity += "| back |"
	scene3.hide()
	scene2.show()


func _on_ManageButton_pressed():
	activity += "| manage |"
	scene3.hide()
	scene4.set_text(current_setting, choices[current_setting])
	scene4.show()


func _on_SaveButton_pressed():
	activity += "| save |"
	if $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene4/HBoxContainer/TextureButton.pressed:
		choices[current_setting] = true
	else:
		choices[current_setting] = false
	if current_setting < 2:
		if current_setting == 0:
			if choices[current_setting]:
				Globals.permissions.requestAccessFineLocationPermission()
			else:
				current_setting += 1
				scene2.set_text(current_setting)
				scene4.hide()
				scene2.show()
		elif current_setting == 1:
			if choices[current_setting]:
				Globals.permissions.requestCameraPermission()
			else:
				current_setting += 1
				scene2.set_text(current_setting)
				scene4.hide()
				scene2.show()
	else:
		if choices[current_setting]:
			Globals.permissions.requestRecordAudioPermission()
		else:
			scene4.hide()
			scene5.show()
			prev.hide()
	


func _on_FinishButton_pressed():
	save_changes()
	self.queue_free()


func _on_PrevButton_pressed():
	if scene2.visible:
		if current_setting == 0:
			scene2.hide()
			scene1.show()
			prev.hide()
		elif current_setting == 1:
			current_setting -= 1
			scene2.set_text(0)
		else:
			current_setting -= 1
			scene2.set_text(1)
	elif scene3.visible:
		scene3.hide()
		scene2.show()
	elif scene4.visible:
		scene4.hide()
		scene3.show()
	else:
		scene5.hide()
		scene2.show()
