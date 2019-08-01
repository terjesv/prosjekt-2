extends Container

onready var popup1 = $MarginContainer/PanelContainer/Popup1
onready var popup2 = $MarginContainer/PanelContainer/Popup2
onready var popup3 = $MarginContainer/PanelContainer/Popup3
onready var scene_1 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene1
onready var scene_2 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene2
onready var scene_3 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene3
onready var scene_5 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene5

onready var prev = $MarginContainer/PanelContainer/VBoxContainer/PanelContainer/PrevButton

var choices = [true, true]
var skull

var activity = ""

func save_changes():
	skull.save_choice(choices[0])
	Globals.set_upgrade(1, choices)
	Globals.set_activity(0, activity)
	self.queue_free()

func _ready():
	Globals.upgrade_menu = self
	popup1.hide()
	popup2.hide()
	popup3.hide()
	scene_2.hide()
	scene_3.hide()
	scene_5.hide()
	prev.hide()

func request_callback(request_code, permissions, granted):
	if popup2.visible:
		if popup2.page == 1 and granted:
			popup2.page += 1
			popup2.text.text = "Read calendar data.\nAllows an application to read your calendar data."
			$MarginContainer/PanelContainer/Popup2/PanelContainer/MarginContainer/VBoxContainer/Button.show()
			$MarginContainer/PanelContainer/Popup2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton.text = "SAVE"
		elif popup2.page == 2 and granted:
			#if $PanelContainer/MarginContainer/VBoxContainer/Button/TextureButton.pressed:
			choices = [true, true]
			activity += "| save on |"
			popup2.hide()
			scene_3.hide()
			scene_5.show()
			prev.hide()
	elif scene_3.visible and request_code == 9 and granted:
		Globals.permissions.requestReadCalendarPermission()
	elif scene_3.visible and request_code == 0:
		if !granted:
			choices[1] = false
		scene_3.hide()
		scene_5.show()
		prev.hide()

func _on_ExitButton_pressed():
	activity += "| exit |"
	popup1.scene = self
	popup1.show()
	
	
#SCENE1____________________________________________________________________
func _on_Scene1Button_pressed():
	scene_1.hide()
	scene_2.show()
	prev.show()
	
#SCENE2____________________________________________________________________
func _on_Scene2Button_pressed():
	scene_2.hide()
	scene_3.show()
	
#SCENE3____________________________________________________________________
func _on_Scene3Button_pressed():
	activity += "| agree |"
	Globals.permissions.requestReadPhoneStatePermission()

func _on_Scene3Manage_pressed():
	activity += "| manage |"
	popup2.show()
	popup2.scene = self
	
func _on_Button_pressed():
	save_changes()

func _on_PrevButton_pressed():
	if scene_2.visible:
		scene_2.hide()
		scene_1.show()
		prev.hide()
	if scene_3.visible:
		scene_3.hide()
		scene_2.show()
	if scene_5.visible:
		scene_5.hide()
		scene_3.show()
