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

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	for value in Autoloadvars.usedscenariospt2:
		if value == inputno:
			inputno = randi_range(1,6)
			print(inputno)
			_init()
			break
	print(inputno)
	Autoloadvars.usedscenariospt2.append(inputno)
	match str(inputno):
		'1':
			text = "What is the IoT"
			buttontext1 = "The internet."
			buttontext2 = "A network of devices, for the purpose of sending and receiving data."
			buttontext3 = "Something with computers."
			affect1 = "OK"
			affect2 = "GOOD"
			affect3 = "BAD"
		'2':
			text = "What do you do as a network technician?"
			buttontext1 = "Click buttons."
			buttontext2 = "Move Wires."
			buttontext3 = " Create a functioning network for your workplace to use."
			affect1 = "BAD"
			affect2 = "BAD"
			affect3 = "GOOD"
		'3':
			text = "How is data sent?"
			buttontext1 = "A magician never reveals his secrets."
			buttontext2 = "It is sent by computers."
			buttontext3 = "It is broken down into packets."
			affect1 = "BAD"
			affect2 = "OK"
			affect3 = "GOOD"
		'4':
			text = "What does a I.P. address do?"
			buttontext1 = "It is a unique identifying number that is given to each of the devices."
			buttontext2 = "An identifier."
			buttontext3 = "A series of numbers for your computer."
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "OK"
		'5':
			text = "Why should we hire you?"
			buttontext1 = "You should hire me because of the fact that I am a hard worker, with goals for the company."
			buttontext2 = "You should hire me because of the fact that I can improve the efficiency of the company."
			buttontext3 = "It would be easier to hire me than other people."
			affect1 = "GOOD"
			affect2 = "GOOD"
			affect3 = "BAD"
		'6':
			text = "Do you have previous training, or internships?"
			buttontext1 = "Yes, I have worked previously at different companies, and have completed many courses on Cisco."
			buttontext2 = "This will be my first time working this job."
			buttontext3 = "I have worked to make my home Network better."
			affect1 = "GOOD"
			affect2 = "OK"
			affect3 = "OK"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
