extends Node
class_name ProblemScenario1

var text : String = "no_text_defined"
var buttontext1 : String = "no_button_text_defined"
var buttontext2 : String = "no_button_text_defined"
var buttontext3 : String = "no_button_text_defined"

var affect1 = "error"
var affect2 = "error"
var affect3 = "error"

var inputno = randi_range(1,12)
var buttonchoiceno

func _init() -> void:
	print("picking...")

	while inputno in Autoloadvars.usedscenariospt1:
		print("choosing new...")
		inputno = randi_range(1, 12)
		print(inputno)
	print(Autoloadvars.usedscenariospt1)

	print("final choice:", inputno)

	Autoloadvars.usedscenariospt1.append(inputno)

	print("setting textboxes...")
	
	# Temporary variables to hold the scenario data before randomizing
	var good_text : String = ""
	var ok_text : String = ""
	var bad_text : String = ""
	
	match str(inputno):

		'1':
			text = "What should you focus on in your case?"
			good_text = "The facts and evidence"
			ok_text = "What people in town are saying"
			bad_text = "Getting it over with"

		'2':
			text = "How can you use Tom's injury in the case?"
			good_text = "Show that he could not have caused Mayella's injuries"
			ok_text = "Offhandedly mention it"
			bad_text = "Forget about it"

		'3':
			text = "When you question Tom, how should you act?"
			good_text = "Calm and collected"
			ok_text = "Fast and impatient"
			bad_text = "Harsh and aggressive"

		'4':
			text = "Some people don't like that you are defending tom. What do you do?"
			good_text = "Keep the case going and do your job"
			ok_text = "Keep your head low to avoid attention"
			bad_text = "Drop the case"

		'5':
			text = "You know racial bias is a large topic within the community. How does this affect your approach?"
			good_text = "You stay focused on the law"
			ok_text = "You ignore it"
			bad_text = "You let it discourage you"

		'6':
			text = "During your closing statement, what should you focus on most?"
			good_text = "The evidence that shows Tom is innocent"
			ok_text = "Your own feelings about the case"
			bad_text = "Rushing the Jury's decision"

		'7':
			text = "Tom was shot 17 times while trying to escape prison. How do you present this to the jury?"
			good_text = "Explain that Tom lost hope in a system that failed him"
			ok_text = "Mention it briefly without context"
			bad_text = "Avoid talking about it entirely"

		'8':
			text = "Mayella's injuries were on the right side of her face. What does this suggest about the attacker?"
			good_text = "The attacker was likely left-handed, and Tom's left arm is crippled"
			ok_text = "It could have been anyone"
			bad_text = "This detail is not important"

		'9':
			text = "Tom says he felt sorry for Mayella. How do you handle this statement in court?"
			good_text = "Explain that compassion is not a crime"
			ok_text = "Quickly move past it"
			bad_text = "Let it stand without explanation"

		'10':
			text = "Bob Ewell is left-handed, which matches the injuries on Mayella. How do you use this?"
			good_text = "Point out that Bob could have caused the injuries himself"
			ok_text = "Mention it but don't emphasize it"
			bad_text = "Ignore this evidence"

		'11':
			text = "Tom helped Mayella with chores out of kindness. How do you present this to the jury?"
			good_text = "Show that Tom was a good neighbor who meant no harm"
			ok_text = "Mention it without much detail"
			bad_text = "Suggest he had other motives"

		'12':
			text = "The Ewells live in poverty near the town dump. How does this context help your case?"
			good_text = "Explain that Bob Ewell has reason to blame others for his problems"
			ok_text = "Briefly mention their living conditions"
			bad_text = "Mock their poverty in front of the jury"

		_:
			text = "error"
			good_text = "error"
			ok_text = "error"
			bad_text = "error"
	
	# Randomize button order
	var choices = [
		{"text": good_text, "affect": "GOOD"},
		{"text": ok_text, "affect": "OK"},
		{"text": bad_text, "affect": "BAD"}
	]
	choices.shuffle()
	
	buttontext1 = choices[0]["text"]
	buttontext2 = choices[1]["text"]
	buttontext3 = choices[2]["text"]
	
	affect1 = choices[0]["affect"]
	affect2 = choices[1]["affect"]
	affect3 = choices[2]["affect"]

func _process(delta: float) -> void:
	pass
