extends Node
class_name ProblemScenario2

var text : String = "no_text_defined"
var buttontext1 : String = "no_button_text_defined"
var buttontext2 : String = "no_button_text_defined"
var buttontext3 : String = "no_button_text_defined"

var affect1 = "error"
var affect2 = "error"
var affect3 = "error"

var inputno = randi_range(1,6)
var buttonchoiceno

func _init() -> void:
	for value in Autoloadvars.usedscenariospt1:
		if value == inputno:
			inputno = randi_range(1,6)
			_init()
			break

	Autoloadvars.usedscenariospt1.append(inputno)

	match str(inputno):

		'1':
			text = "You are defending Tom Robinson in court. What is the most important thing to focus on?"
			buttontext1 = "The facts and evidence"
			buttontext2 = "What people in town are saying"
			buttontext3 = "Finishing the trial quickly"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'2':
			text = "You notice that Tom Robinson’s left arm is injured. How do you use this in the trial?"
			buttontext1 = "Show that he could not have caused the injuries"
			buttontext2 = "Mention it briefly without explaining"
			buttontext3 = "Ignore it"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'3':
			text = "When you question Tom Robinson on the stand, how should you act?"
			buttontext1 = "Calm and respectful"
			buttontext2 = "Fast and impatient"
			buttontext3 = "Harsh and aggressive"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'4':
			text = "Some people react negatively to you defending Tom Robinson. What do you do?"
			buttontext1 = "Continue the case and do your job"
			buttontext2 = "Change how you act to avoid attention"
			buttontext3 = "Step back from the case"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'5':
			text = "You know racial bias exists in the town. How does this affect your approach in court?"
			buttontext1 = "You stay focused on fairness and the law"
			buttontext2 = "You avoid addressing it at all"
			buttontext3 = "You let it discourage you"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'6':
			text = "During your closing statement, what do you focus on most?"
			buttontext1 = "The evidence that shows Tom Robinson is innocent"
			buttontext2 = "Your own feelings about the case"
			buttontext3 = "Rushing the jury to decide"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		_:
			text = "error"
			buttontext1 = "error"
			buttontext2 = "error"
			buttontext3 = "error"
#
#func _process(delta: float) -> void:
	#pass
