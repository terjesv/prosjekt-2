extends VBoxContainer

func init(question):
	find_node("Label").text = question["question"]
	find_node("Label").autowrap = true

func get_answer():
	var question = find_node("Label").text
	var answer = find_node("LineEdit").text
	if not answer:
		return null
	return [question, answer]