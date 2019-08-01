extends Container

var level
var active
var parent
onready var active_1 = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Option1Container/ActiveLabel
onready var active_2 = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Option2Container/ActiveLabel
onready var active_3 = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Option3Container/ActiveLabel
onready var option_1 = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Option1Container
onready var option_2 = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Option2Container
onready var option_3 = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Option3Container

func _ready():
	var active_label = [active_1, active_2, active_3]
	var option = [option_1, option_2, option_3]
	for i in range(0, 3):
		if i < level:
			if active[i]:
				active_label[i].set_text("(Activated)")
				active_label[i].add_color_override("font_color", Color(0, 180, 0, 1))
			else:
				active_label[i].set_text("(Deactivated)")
				active_label[i].add_color_override("font_color", Color(180, 0, 0, 1))
		else:
			option[i].hide()


func _on_EditButton1_pressed():
	parent.show_setting(active[0], 1)
	parent.save_activity(level, "edit_1")
	self.queue_free()


func _on_EditButton2_pressed():
	parent.show_setting(active[1], 2)
	parent.save_activity(level, "edit_2")
	self.queue_free()


func _on_EditButton3_pressed():
	parent.show_setting(active[2], 3)
	parent.save_activity(level, "edit_3")
	self.queue_free()


func _on_SaveButton_pressed():
	parent.save_activity(level, "save")
	parent.queue_free()


func _on_ActivateButton_pressed():
	for i in range(0, level):
		active[i] = true
		parent.save_setting(i+1, active[i])
	parent.save_activity(level, "activate_all")
