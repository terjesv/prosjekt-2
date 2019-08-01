extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()
var friction = false

var sword_sound = load("res://entities/player/sounds/sword-gesture1.ogg")
var punch_sound = load("res://entities/player/sounds/punchsound.ogg")
var bow_sound = load("res://entities/player/sounds/Arrowswosh.ogg")
onready var sound_player = $"../AudioStreamPlayer"

const FISTS = 0
const SWORD = 1

const IDLE = 0
const GETUP = 1
const KNOCKDOWN = 2
const RUNLEFT = 3
const RUNRIGHT = 4
const JUMP = 5
const ATTACK = 6
const HURT = 7
const DIE = 8
const STAGGER = 9
const BOW = 10

enum Weapons { FISTS, SWORD }

const ARROW = preload("res://entities/player/player_arrow.tscn")
var bow_timer = null


#Different possible states, have not implemented STAGGER
enum STATES { IDLE, GETUP, KNOCKDOWN, RUNLEFT, RUNRIGHT, JUMP, ATTACK, HURT, DIE, STAGGER, BOW}

signal health_changed
signal died

var current_state = null
var previous_state = null
var next_state = null

var idle_animation = "Idle"
var hurt_animation = "HurtNoSword"
var current_weapon = FISTS
var previous_weapon = null
var next_weapon = null
var attack_sound = null

var attack_animation = null
var attack_frame = null
var attack_over_frame = null

var can_shoot = false
var has_bow = null
var not_shot = true

#var to check if attack is over
var attack_is_over = true
var damage_immunity = false
var immunity_timer = null

export var max_health = 10
var health

var damage = 1

var max_depth = null

var is_on_moving_platform = false

func _ready():
	set_max_health()
	set_sword_upgrade()
	set_bow_upgrade()
	health = max_health - Globals.health_penalty

	bow_timer = Timer.new()
	bow_timer.set_one_shot(true)
	bow_timer.set_wait_time(0.3)
	bow_timer.connect("timeout", self, "on_bow_timeout")
	add_child(bow_timer)

	immunity_timer = Timer.new()
	immunity_timer.set_one_shot(true)
	immunity_timer.set_wait_time(1.5)
	immunity_timer.connect("timeout", self, "on_immunity_timeout")
	add_child(immunity_timer)

	if get_tree().get_current_scene().get("max_depth"):
		max_depth = get_tree().get_current_scene().get("max_depth")
	current_state = JUMP
	emit_signal("health_changed", health)

func play_sound(sound, volume = 0):
	sound_player.stream = sound
	sound_player.volume_db = volume
	if !Globals.muted[1]:
		sound_player.play()

#returns true if state change is possible
func is_change_state_possible():

		if current_state == DIE:
			return false
		elif previous_state == DIE:
			return false

		elif previous_state == KNOCKDOWN && next_state == GETUP:
			return true

		elif current_state == KNOCKDOWN:
			return false
		elif previous_state == KNOCKDOWN:
			return false

		elif current_state == GETUP && $Sprite.get_frame() == 6:
			return true

		elif current_state == GETUP:
			return false
		elif previous_state == GETUP:
			return false

		elif current_state == BOW && $Sprite.get_frame() == 8:
			return true

		elif current_state == BOW && next_state == KNOCKDOWN:
			return true
			
		elif current_state == BOW:
			return false
#		elif previous_state == BOW:
#			return false

		elif not attack_is_over:
			return false

		elif not is_on_floor() && next_state == ATTACK || not is_on_floor() && previous_state == ATTACK :
			return true

		elif not is_on_floor() && next_state == JUMP  && current_state == RUNLEFT\
		|| not is_on_floor() && next_state == JUMP && current_state == RUNRIGHT:
			return true

		elif not is_on_floor() && next_state == JUMP  && current_state == IDLE:
			return true

		elif not is_on_floor() && next_state == KNOCKDOWN:
			return true



		elif not is_on_floor():
			return false
		else:
			return true


func change_weapon(new_weapon):
	previous_weapon = current_weapon
	next_weapon = new_weapon
	current_weapon = new_weapon

	match current_weapon:
		FISTS:
			idle_animation = "Idle"
			attack_animation = "Punch"
			attack_sound = punch_sound
			attack_frame = 1
			attack_over_frame = 3
			damage = 1

		SWORD:
			idle_animation = "Idle Sword"
			attack_animation = "Melee2"
			hurt_animation = "Hurt"
			attack_sound = sword_sound
			attack_frame = 3
			attack_over_frame = 5
			damage = 2



func on_bow_timeout():
	can_shoot = true


func on_immunity_timeout():
	damage_immunity = false
	immunity_timer.stop()




#Changes player state
func change_state(new_state):
	previous_state = current_state
	next_state = new_state

	if is_change_state_possible():
		current_state = new_state


	match current_state:
		IDLE:
			$Sprite.play(idle_animation)
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)

		KNOCKDOWN:
			immunity_timer.start()
			damage_immunity = true
			$Sprite.play("Knockdown")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
			if $Sprite.get_frame() == 6 && is_on_floor():
				change_state(GETUP)


		GETUP:
			$Sprite.play("Get Up")
			friction = false
			motion.x = 0




		RUNLEFT:

			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Area2D.set_scale(Vector2(-1, 1))
			$Sprite.play("Run")

		RUNRIGHT:
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Area2D.set_scale(Vector2(1, 1))
			$Sprite.play("Run")

		JUMP:
			if is_on_floor():
				if Input.is_action_just_pressed("ui_up"):
					motion.y = JUMP_HEIGHT
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.12)
			else:
				if Input.is_action_pressed("ui_left"):
					motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
					$Sprite.flip_h = true
					$Area2D.set_scale(Vector2(-1, 1))

				elif Input.is_action_pressed("ui_right"):
					motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
					$Sprite.flip_h = false
					$Area2D.set_scale(Vector2(1, 1))

				elif Input.is_action_just_pressed("ui_attack"):
						change_state(ATTACK)

				if motion.y < 0:
					$Sprite.play("Jump")
				elif motion.y > 0 and !is_on_moving_platform:
					$Sprite.play("Fall")
					if friction == true:
						motion.x = lerp(motion.x, 0, 0.12)


		ATTACK:
			attack_is_over = false
			$Sprite.play(attack_animation)
			play_sound(attack_sound, -10)
			if $Sprite.get_frame() == attack_frame:
				var bodies = $Area2D.get_overlapping_bodies()
				for body in bodies:
					if body.is_in_group("Enemy"):
						body.hitstun = 10
						body.knockdir = global_transform.origin - body.global_transform.origin
						body.take_damage(damage)
			if $Sprite.get_frame() == attack_over_frame:
				attack_is_over = true
				if not is_on_floor():
					change_state(JUMP)

		BOW:
			$Sprite.play("Ranged")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)

			if $Sprite.get_frame() == 7:
				if not_shot:
					play_sound(bow_sound, -10)
					var player_arrow = ARROW.instance()
					get_tree().get_current_scene().add_child(player_arrow)

					if $Sprite.flip_h == false:
						player_arrow.speed= player_arrow.speed
						player_arrow.position = $Position2D.global_position
					else:
						player_arrow.speed= -player_arrow.speed
						player_arrow.position = $Position2D.global_position -Vector2(70,0)
					not_shot = false
					can_shoot = false

		HURT:
			$Sprite.play(hurt_animation)
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)

		DIE:
			$Sprite.play("Death")
			if $Sprite.get_frame() == 6:
				restart_level()

func _physics_process(delta):
	motion.y += GRAVITY

	if damage_immunity:
		if Engine.get_frames_drawn() % 15 == 0:
			self.modulate.a = 0.2
		else:
			self.modulate.a = 1
	else:
		self.modulate.a = 1

	if max_depth and position.y > max_depth:
		restart_level()

	elif health < 1:
		change_state(DIE)

	elif Input.is_action_just_pressed("ui_up"):
		change_state(JUMP)


	elif Input.is_action_just_pressed("ui_attack"):
		bow_timer.start()


	elif Input.is_action_just_released("ui_attack"):
		#Check for NPC conversation
		if get_parent().getDiDialogueSource() != null:
			get_node(get_parent().getDiDialogueSource()).converse()
		elif can_shoot && has_bow:
			not_shot = true
			change_state(BOW)
			bow_timer.stop()
		else:
			change_state(ATTACK)
			bow_timer.stop()

	elif not is_on_floor():
		change_state(JUMP)

	elif Input.is_action_pressed("ui_right"):
		change_state(RUNRIGHT)

	elif Input.is_action_pressed("ui_left"):
		change_state(RUNLEFT)




	else :
		if health <= max_health && health >= 5:
			change_state(IDLE)
		elif health < 5 && health > 0:
			change_state(HURT)

	#
	if is_on_moving_platform && get_floor_velocity().y > 0:
		motion.y += get_floor_velocity().y
	elif is_on_moving_platform && get_floor_velocity().y < 0:
		motion.y -= get_floor_velocity().y
	motion = move_and_slide(motion, UP)


func restart_level():
	get_tree().reload_current_scene()


#helper func so that the player can take damage
func take_damage(count):
	if not damage_immunity:
		health -= count
		if health <= 0:
			health = 0
			change_state(DIE)
		else:
			change_state(KNOCKDOWN)
		emit_signal("health_changed", health)
		


func upgrade_changed(upgrade):
	if upgrade == 1:
		set_max_health()
		health = max_health
		emit_signal("health_changed", health)
	if upgrade == 2:
		set_sword_upgrade()
	if upgrade == 3:
		set_bow_upgrade()

func set_max_health():
	if Globals.get_upgrade(1)[0]:
		max_health = 15
	else:
		max_health = 10
	get_parent().get_node("Interface").set_health_bar(max_health)

func set_sword_upgrade():
	if Globals.get_upgrade(2)[0]:
		change_weapon(SWORD)
	else:
		change_weapon(FISTS)

func set_bow_upgrade():
	if Globals.get_upgrade(3)[0]:
		has_bow = true
	else:
		has_bow = false
