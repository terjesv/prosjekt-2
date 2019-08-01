extends Node

onready var choice = preload("res://menus/choices/ChoiceMenu.tscn")

func _on_Button_pressed():
	var c = choice.instance()
	self.add_child(c)
	c.level = 1
	c.end_level = false
	c.choice(self)