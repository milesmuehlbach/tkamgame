extends Node
class_name ProblemScenario1

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
	print("picking...")

	while inputno in Autoloadvars.usedscenariospt1:
		print("choosing new...")
		inputno = randi_range(1, 6)
		print(inputno)
	print(Autoloadvars.usedscenariospt1)

	print("final choice:", inputno)

	Autoloadvars.usedscenariospt1.append(inputno)

	print("setting textboxes...")
	match str(inputno):

		'1':
			text = "What should you focus on in your case?"
			buttontext1 = "The facts and evidence"
			buttontext2 = "What people in town are saying"
			buttontext3 = "Getting it over with"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'2':
			text = "How can you use Tom's injury in the case?"
			buttontext1 = "Show that he could not have caused Mayella's injuries"
			buttontext2 = "Offhandedly mention it"
			buttontext3 = "Forget about it"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'3':
			text = "When you question Tom, how should you act?"
			buttontext1 = "Calm and collected"
			buttontext2 = "Fast and impatient"
			buttontext3 = "Harsh and aggressive"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'4':
			text = "Some people don't like that you are defending tom. What do you do?"
			buttontext1 = "Keep the case going and do your job"
			buttontext2 = "Keep your head low to avoid attention"
			buttontext3 = "Drop the case"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'5':
			text = "You know racial bias is a large topic within the community. How does this affect your approach?"
			buttontext1 = "You stay focused on the law"
			buttontext2 = "You ignore it"
			buttontext3 = "You let it discourage you"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		'6':
			text = "During your closing statement, what should you focus on most?"
			buttontext1 = "The evidence that shows Tom is innocent"
			buttontext2 = "Your own feelings about the case"
			buttontext3 = "Rushing the Jury's decision"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"

		_:
			text = "error"
			buttontext1 = "error"
			buttontext2 = "error"
			buttontext3 = "error"

func _process(delta: float) -> void:
	pass
