extends Node

var current_round = 0
var pumps_left
const max_rounds = 10
const max_pumps = 32
var score = 0
var total_score = 0
var rounds_won = 0

func _ready():
	randomize()
	$PanelContainer/MarginContainer/VBoxContainer.hide()
	new_round()
	get_tree().get_root().get_node("Globals").music_player.stop()
		
func new_round():
	$PanelContainer/MarginContainer/Popup.hide()
	$PanelContainer/MarginContainer/HBoxContainer2.show()
	pumps_left = max_pumps
	score = 0
	current_round += 1
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/RoundLabel.text = str(current_round)
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/ScoreLabel.text = str(score)
	$PanelContainer/BalloonSprite.scale = Vector2(0.5, 0.5)
	$PanelContainer/BalloonSprite.rotation_degrees = 0
	
func finish():
	var risk_profile = "NA"
	if rounds_won > 0:
		var aggregate = total_score / rounds_won
		get_tree().get_root().get_node("Globals").set_bart_score(total_score, aggregate)
		
		
		if aggregate <= 10:
			risk_profile = "low"
		elif aggregate <= 20:
			risk_profile = "medium"
		elif aggregate <= 32:
			risk_profile = "high"
	$PanelContainer/MarginContainer/VBoxContainer/RiskLabel.text = "The test indicated that your inclination towards risk is relativily " + risk_profile + "."
	
	$PanelContainer/BalloonSprite.texture = null
	$PanelContainer/MarginContainer/Popup.hide()
	$PanelContainer/MarginContainer/HBoxContainer.hide()
	$PanelContainer/MarginContainer/HBoxContainer2.hide()
	$PanelContainer/MarginContainer/VBoxContainer/ScoreLabel.text = str(total_score)
	$PanelContainer/MarginContainer/VBoxContainer.show()
	
func _on_PumpButton_pressed():
	if explode(pumps_left+1) && pumps_left != max_pumps:
		$PanelContainer/BalloonSprite.scale = Vector2(0, 0)
		$PanelContainer/MarginContainer/Popup.show()
		$PanelContainer/MarginContainer/HBoxContainer2.hide()
	else:
		$PanelContainer/BalloonSprite.scale += Vector2(0.02, 0.02)
		rotate_balloon()
		score += 1
		$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/ScoreLabel.text = str(score)
		pumps_left -= 1

func _on_CollectButton_pressed():
	if score > 0:
		total_score += score
		$PanelContainer/MarginContainer/HBoxContainer/TotalScoreLabel.text = str(total_score)
		rounds_won += 1
		if current_round < max_rounds:
			new_round()
		else:
			finish()
	
func _on_OKButton_pressed():
	if current_round < max_rounds:
		new_round()
	else:
		finish()

func _on_NextButton_pressed():
	get_tree().change_scene('res://levels/prison/prison.tscn')


func explode(number):
	return number == randi()%number+1

func rotate_balloon():
	if randi()%3+1 == 1:
		$PanelContainer/BalloonSprite.rotation_degrees = randi()%6+1
	else:
		$PanelContainer/BalloonSprite.rotation_degrees = -(randi()%6+1)