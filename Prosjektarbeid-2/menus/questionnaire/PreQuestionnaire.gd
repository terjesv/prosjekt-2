extends Questionnaire

var questions = [
{	"type": RADIO,
	"question": "Sex",
	"radios": ["Male", "Female", "Other"]},
	
{	"type": RADIO,
	"question": "Age",
	"radios": ["<13", "14-18", "19-25", "26-35", "36+"]},
	
{	"type": RADIO,
	"question": "Highest Educational Level",
	"radios": ["Primary school", "Highschool", "University", "No Education"]},
	
{	"type": RADIO,
	"question": "Game Experience Level",
	"radios": ["No Experience", "Beginner", "Intermediate", "Expert"]},
]

func write_to_Globals(answers):
	Globals.pre_questionnaire = answers

func goto_next():
	get_tree().change_scene('res://levels/BART/BARTIntro.tscn')


func _ready():
	.init(questions)
