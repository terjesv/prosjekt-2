extends KinematicBody2D

const GRAVITY = 0

var speed = 210
var velocity = Vector2()
var damage = 1

func _ready():
	
	pass

func _physics_process(delta):
	
	if speed < 0:
		$Sprite.flip_h = true
	
	velocity.x = speed * delta
	
	velocity.y = GRAVITY * delta
	
	translate(velocity)
	
	
	var bodies = $Area2D.get_overlapping_bodies()
	
	for body in bodies:
		
		if body.is_in_group("character"):
			body.take_damage(damage)
			queue_free()
	


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


	
