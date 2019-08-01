extends VBoxContainer

var radio_button = load("res://menus/questionnaire/question_fields/RadioButton.tscn")

func generate_radio(identifier):
	var label = str(identifier)
	var hbox = find_node("HBoxContainer")

	var rinstance = radio_button.instance()
	hbox.add_child(rinstance)
	rinstance.text = label

func init(question):
	find_node("Label").text = question["question"]
	find_node("Label").autowrap = true
	
	var rtype = typeof(question["radios"])
	if rtype == TYPE_INT:
		for i in range(question["radios"]):
			generate_radio(i)
	elif rtype == TYPE_ARRAY:
		for r in question["radios"]:
			generate_radio(r)

func get_answer():
	var question = find_node("Label").text
	var answer = false
	
	for child in find_node("HBoxContainer").get_children():
		if child.pressed:
			answer = child.text
	
	if not answer:
		return null
	return [question, answer]