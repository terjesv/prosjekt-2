extends Questionnaire

var questions = [
{	"type": RADIO,
	"question": "Did you learn anything about sharing private data from this game?",
	"radios": ["Not at all", "Somewhat", "A lot"]},
{	"type": RADIO,
	"question": "Did you think through your choices when responding to the upgrade offers?",
	"radios": ["Not at all", "Somewhat", "A lot"]},
{	"type": LINE,
	"question": "Why did you make the choice you did on the health upgrade?"},
{	"type": LINE,
	"question": "Why did you make the choice you did on the sword upgrade?"},
{	"type": LINE,
	"question": "Why did you make the choice you did on the bow upgrade?"},
{	"type": RADIO,
	"question": "Would you be likely to make different choices on following playthroughs?",
	"radios": ["Not at all", "Somewhat", "A lot"]},
{	"type": RADIO,
	"question": "Will this experience impact your future choices relating to sharing private data?",
	"radios": ["Not at all", "Somewhat", "A lot"]},
{	"type": LINE,
	"question": "What do you think about the game?"}
]

func write_to_Globals(answers):
	Globals.post_questionnaire = answers

func goto_next():
	get_tree().change_scene("res://menus/Resendemail.tscn")

func _ready():
	.init(questions)
