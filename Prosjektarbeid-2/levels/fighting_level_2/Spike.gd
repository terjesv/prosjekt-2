extends Area2D

var damage = 1

func _on_SpikeArea2D_body_entered(body):
	if body.is_in_group("character"):
		body.take_damage(damage)
