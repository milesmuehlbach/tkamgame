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

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	print("picking...")
	for value in Autoloadvars.usedscenariospt1:
		if value == inputno:
			print("choosing new...")
			inputno = randi_range(1,6)
			print(inputno)
			_init()
			break
	print(inputno)
	Autoloadvars.usedscenariospt1.append(inputno)
	print("setting textboxes...")
	match str(inputno):
		'1':
			text = "A hacker is attacking our network! What's the first thing to do?"
			buttontext1 = "Tell the boss right away"
			buttontext2 = "Find the problem and stop it from spreading"
			buttontext3 = "Shut down every computer"
			affect1 = "BAD"
			affect2 = "GOOD"
			affect3 = "OK"
		'2':
			text = "How do hackers usually break into a company’s systems?"
			buttontext1 = "By sending fake emails to trick people into clicking bad links"
			buttontext2 = "By guessing random passwords"
			buttontext3 = "By sneaking into the office and stealing a computer"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"
		'3':
			text = "We stopped the hacker—now what?"
			buttontext1 = "Check the computer logs to see what they did"
			buttontext2 = "Restart everything and hope for the best"
			buttontext3 = "Ignore it since the attack is over"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"
		'4':
			text = "Why does a cyberattack matter to a company?"
			buttontext1 = "It can cost a lot of money and make people lose trust"
			buttontext2 = "It's just annoying for a little while"
			buttontext3 = "It doesn’t really hurt the company"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"
		'5':
			text = "How can we stop this from happening again?"
			buttontext1 = "Train employees and check security regularly"
			buttontext2 = "Change passwords once a year"
			buttontext3 = "Install antivirus and call it a day"
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "BAD"
		'6':
			text = "We fixed the problem! What’s the last step?"
			buttontext1 = "Write down what happened and improve security"
			buttontext2 = "Hope that hackers don’t attack again"
			buttontext3 = "Tell employees to be more careful next time"
			affect1 = "GOOD"
			affect2 = "BAD"
			affect3 = "OK"
		_:
			text = "error"
			buttontext1 = "error"
			buttontext2 = "error"
			buttontext3 = "error"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
