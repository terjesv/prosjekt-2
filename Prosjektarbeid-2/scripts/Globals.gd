extends Node

var main_menu_song = load("res://levels/common/assets/sounds/Fantastic A.ogg")
var city_song = load("res://levels/common/assets/sounds/The Walrus and the Carpenter.ogg")
var farm_song = load("res://levels/common/assets/sounds/bensound-relaxing.ogg")
var skull_song = load("res://levels/common/assets/sounds/bensound-ofeliasdream.ogg")
var fighting_song = load("res://levels/common/assets/sounds/bensound-instinct.ogg")
var boss_song = load("res://levels/common/assets/sounds/bensound-epic.ogg")
var ending_song = load("res://levels/common/assets/sounds/bensound-betterdays.ogg")
var credit_song = load("res://levels/common/assets/sounds/bensound-love.ogg")
var boss_dead_song = load("res://levels/common/assets/sounds/bensound-birthofahero.ogg")
var music_player = AudioStreamPlayer.new()
var muted = [false, false]
# A reference to the music/sound buttons are needed to remember their state
# across scene changes.
var music_button
var sound_button

var data_sharing_mode = null
var player_id = null

#Variable that holds a reference to a permission handler singleton
var permissions = null

#Updated on skull levels
var upgrade_menu

func _ready():
	self.add_child(music_player)
	
	# If game is deployed on android, sets ut singleton that handles permissions
	if Engine.has_singleton("AndroidPermissions"):
		permissions = Engine.get_singleton("AndroidPermissions")
		permissions.init(get_instance_id(), false)
		

# Callback from permission prompt
func _on_request_permission_result(request_code, permissions, granted):
	upgrade_menu.request_callback(request_code, permissions, granted)

var upgrades =  {   1: [false, false],
		            2: [false, false, false],
		            3: [false, false, false]
		         }
var health_penalty = 0

var upgrade_activity = ["", "", ""]

var bart_score
var bart_aggregate

var pre_questionnaire = []
var post_questionnaire = []

func flush():
	health_penalty = 0
	upgrade_activity = ["", "", ""]
	pre_questionnaire = []
	post_questionnaire = []
	upgrades =  {   1: [false, false],
		            2: [false, false, false],
		            3: [false, false, false]
		         }
	data_sharing_mode = null

func play_song(song, volume = 0):
	# Updates the song and volume, and if not muted starts the song
	music_player.stream = song
	music_player.volume_db = volume
	if !muted[0]:
		music_player.play()

func set_upgrade(upgrade, value):
	for i in value.size():
		upgrades[upgrade][i] = value[i]
	get_tree().get_root().get_node("Skull_level_" + str(upgrade) + "/Player/KinematicBody2D").upgrade_changed(upgrade)

func get_upgrade(upgrade):
	return upgrades[upgrade]
	
func get_all_upgrades():
	return upgrades
	
func get_shared_options():
	var sum = 0
	for opts in get_all_upgrades().values():
		for opt in opts:
			if opt:
				sum += 1
	return sum

func get_total_sharing_options():
	var sum = 0
	for opts in get_all_upgrades().values():
		sum += opts.size()
	return sum

func get_activated_upgrades():
	var sum = 0
	for opts in get_all_upgrades().values():
		for opt in opts:
			if opt:
				sum += 1
				break
	return sum
	
func set_activity(activity, string):
	upgrade_activity[activity] = string
	
func set_bart_score(score, aggregate):
	bart_score = score
	bart_aggregate = aggregate

# daretoshare.results
func send_email():
	var mailstring = "mailto:daretoshare.results@gmail.com?subject=Results&body="

	mailstring += "Player ID: " + str(player_id) + "\n\n"
	mailstring += "Pre questionnaire\n"
	for answer in pre_questionnaire:
		mailstring += format_data(answer) + "%0A"
	mailstring += "\n"
		
	mailstring += "BART score: " + str(bart_score) + "\n"
	mailstring += "BART aggregate: " + str(bart_aggregate) + "\n\n"
	
	mailstring = format_upgrades(mailstring)
	
	mailstring += "Upgrade activities:\n"
	for activity in upgrade_activity:
		mailstring += activity + "%0A"
		mailstring += "\n"
	mailstring += "\n"
	
	mailstring += "Post questionnaire:\n"
	for answer in post_questionnaire:
		mailstring += format_data(answer) + "%0A"
	mailstring += "\n"
	
	OS.shell_open(mailstring)
	
func format_data(level):
	var datastring = "| "
	for data in level:
		datastring += data+" | "
	return datastring
	
func format_upgrades(mailstring):
	mailstring += "Health upgrade:\n"
	mailstring += "Read phone state (required for upgrade): " + str(upgrades[1][0]) + "\n"
	mailstring += "Read calendar data: " + str(upgrades[1][1]) + "\n\n"
	
	mailstring += "Sword upgrade:\n"
	mailstring += "Read contacts (required for upgrade): " + str(upgrades[2][0]) + "\n"
	mailstring += "Read call log: " + str(upgrades[2][1]) + "\n"
	mailstring += "Read SMS: " + str(upgrades[2][2]) + "\n\n"
	
	mailstring += "Bow upgrade:\n"
	mailstring += "Location (required for upgrade): " + str(upgrades[3][0]) + "\n"
	mailstring += "Camera: " + str(upgrades[3][1]) + "\n"
	mailstring += "Record audio: " + str(upgrades[3][2]) + "\n\n"
	return mailstring
