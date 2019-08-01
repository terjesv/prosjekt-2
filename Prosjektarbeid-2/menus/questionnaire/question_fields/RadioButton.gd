extends CheckBox

var is_radio = true

func _ready():
	connect("toggled", self, "_on_RadioButton_toggled")

func _on_RadioButton_toggled(toggle):
	for child in get_parent().get_children():
		if child.is_radio: #Might cause complaints if non-radio children?
			child.pressed = false
			pressed = true
