extends PanelContainer

class_name Questionnaire

#To make a questionnaire, create another scene that extends Questionnaire.
#That scene needs var questions, which is a list of dictionaries,
#where each dictionary defines a question.
#Under "type", put the question's type, i.e. line or radio.
#Under "question", put the question text.
#For radios, under "radios", put the labels of the radio buttons,
#either by an integer (which then generates radio buttons for 1, ..., n,
#or a list of strings, which are then used for the labels.



enum {LINE, RADIO, SUBMIT}

var qnodes = [] #For easy enumerated access to question nodes
func gen_path(s):
	var rel = "res://menus/questionnaire/question_fields/"
	return load(rel + s + ".tscn")

var question_path = {
	LINE:
		gen_path("LineField"),
	RADIO:
		gen_path("RadioField"),
	SUBMIT:
		gen_path("SubmitButton")
}

func generate_question(question):
	var qinstance = question_path[question["type"]].instance()
	$MC/SC/VBC.add_child(qinstance)
	qnodes.append(qinstance)
	qinstance.init(question)

func generate_submit():
	var sbinstance = question_path[SUBMIT].instance()
	$MC/SC/VBC.add_child(sbinstance)
	sbinstance.connect("pressed", self, "_on_SubmitButton_pressed")

func invalid_answer(qnode):
	"Extend to handle stuff like marking an unanswered question, showing a pop-up, wutevs."
	return null

func init(questions):
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	
	VisualServer.set_default_clear_color("fffdd0")

	for question in questions:
		generate_question(question)
	generate_submit()

func _on_SubmitButton_pressed():
	var answers = []
	for q in qnodes: #build the answers list or exit if invalid answer
		var answer = q.get_answer()
		answers.append(answer)
		if answer == null:
			return invalid_answer(q)
	finish_questionnaire(answers)

func write_to_Globals(answers):
	pass

func goto_next():
	pass

func finish_questionnaire(answers):
	write_to_Globals(answers)
	VisualServer.set_default_clear_color("4d4d4d") #Default colour per project settings
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_LANDSCAPE)
	goto_next()
	
