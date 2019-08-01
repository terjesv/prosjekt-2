extends Node2D


func _ready():
	get_node("Sprite").hide()
	

func _on_ExplosionStart_timeout():
	get_node("Sprite").show()
	get_node("Sprite/AnimationPlayer").play("explode")
	get_node("../../Platforms/Exploding_bricks").queue_free()


func _on_ExplosionEnd_timeout():
	get_node("Sprite").hide()