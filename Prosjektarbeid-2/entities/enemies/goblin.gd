extends "res://entities/enemies/enemy.gd"

const ARROW = preload("arrow.tscn")


var arrowtimer = null

# when can_shoot set to true the a arroww will fire from goblin
var can_shoot = true
var in_camera = false



# Sets up a timer for when a arrow can be fired 
func _ready():
	arrowtimer = Timer.new()
	arrowtimer.set_one_shot(true)
	arrowtimer.set_wait_time(2)
	arrowtimer.connect("timeout", self, "on_timeout")
	add_child(arrowtimer)
#when timer runs out the can_shoot is set to true
	
func on_timeout():
	can_shoot=true
	
	

func _physics_process(delta):
	
	
	if in_camera:
		fire_arrow()
		
		
		

	

func _on_VisibilityNotifier2D_screen_entered():
	in_camera = true
	



func _on_VisibilityNotifier2D_screen_exited():
	in_camera = false

func fire_arrow():
	if can_shoot:
		speed = 0
		_change_state(IDLE)
		_change_state(SHOT)
		var arrow = ARROW.instance()
		get_parent().add_child(arrow)
		if $AnimatedSprite.flip_h == false:
			arrow.position = $Position2D.global_position
		else:
			
			arrow.speed= -arrow.speed
			arrow.position = $Position2D.global_position
		
		can_shoot = false
		speed = max_speed
		arrowtimer.start()
		