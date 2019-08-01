extends Node2D

var dialogueSource = null

func _ready():
	pass

func _process(delta):
	if dialogueSource != null:
		pass
		
func setDialogueSource(source):
	dialogueSource = source
	
func getDiDialogueSource():
	return dialogueSource
