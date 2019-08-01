extends CanvasLayer

var next

func _ready():
	$Panel.modulate.a = 0
	
func _process(delta):
	$Panel.modulate.a += 0.01
	if $Panel.modulate.a > 0.99:
		get_tree().change_scene(next)