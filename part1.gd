extends Node2D

# ---------------- NODES ----------------
@onready var desk = $Desk
@onready var deskbg = $Deskbg
@onready var textboxani: AnimationPlayer = $"Railroad-idle/AnimationPlayer"
@onready var dialogue_label: Label = $"Railroad-idle/dialouge" # Cached for performance
@onready var problemani: AnimationPlayer = $problem/AnimationPlayer
@onready var fadeani: AnimationPlayer = $fade/AnimationPlayer

# ---------------- STATE ----------------
var talking: bool = false
var tutorial: bool = false
var debug: bool = false
var isresponse: bool = false
var isgameover: bool = false

var buttonno := 0
var scenariocounter := 0
var money: int = 500000
var textspeed := 0.015

var current_affects: Array = []

# ---------------- SIGNALS ----------------
signal pressedspace
signal tutorialcontinue
signal finishtalking
signal gameover
signal buttonpress
signal np

# ---------------- READY ----------------
func _ready() -> void:
	problemani.play("RESET")
	$ColorRect/AnimationPlayer.play("RESET")
	dialogue_label.text = ""
	
	# Connect gameover signal to handler
	gameover.connect(_on_gameover)

	runtutorial()

func say(text: String): 
	var lasttext := "" 
	$"Railroad-idle/dialouge".text = ""
	talking = true 
	for i in text.length(): 
		lasttext += text[i] 
		$"Railroad-idle/dialouge".text = lasttext 
		await get_tree().create_timer(textspeed).timeout 
	talking = false 
	finishtalking.emit()

# ---------------- TUTORIAL ----------------
func runtutorial() -> void:
	# 1. Slide the textbox up first
	textboxani.play("slideup")
	await textboxani.animation_finished 
	
	# 2. Now start the dialogue
	await say("Hey there. It's the 1930s, and my name is Atticus Finch. (Press Space to Continue)")
	await pressedspace

	await say("We are in court for Tom Robinson, a black man accused of a crime he didn't do.")
	await pressedspace

	await say("As his attorney, I have to help him win, no matter what.")
	await pressedspace

	await say("You will receive a series of questions, each with three answer choices. Your choice affects the case.")
	await pressedspace

	await say("GOOD choices help you win. Two OK choices in a row become a BAD choice. BAD choices end the trial.")
	await pressedspace

	await say("The court is now in session.")
	await get_tree().create_timer(1.0).timeout

	tutorial = false
	textboxani.play("slidedown")
	await textboxani.animation_finished
	
	gameloop(1)

# ---------------- PROCESS ----------------
func _process(_delta: float) -> void:
	# FIX: Only play "idle" if no other important animation is playing
	if (tutorial or isresponse) and not textboxani.is_playing():
		textboxani.play("idle")

	mouseadj(desk, 30, 70, -140)
	mouseadj(deskbg, 100, 100, 0)

# ---------------- INPUT ----------------
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("space"):
		# If we are currently typing, skip the animation (optional polish)
		if talking:
			# You could add logic here to finish the tween early
			pass
		pressedspace.emit()

# ---------------- MOUSE PARALLAX ----------------
func mouseadj(item: Node2D, intensityy: float, intensityx: float, yoffset: float) -> void:
	var mousepos = get_viewport().get_mouse_position()
	item.position.x = clamp(mousepos.x, 0, 1100) / intensityx
	item.position.y = clamp(mousepos.y, 0, 650) / intensityy + yoffset

# ---------------- CALLBACKS ----------------
func _on_gameover() -> void:
	isgameover = true
	get_tree().change_scene_to_file("res://gameover.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slideup":
		tutorial = true
	elif anim_name == "slidedown":
		$"Railroad-idle".visible = false

# ---------------- BUTTONS ----------------
func _button1pressed() -> void:
	if tutorial: tutorialcontinue.emit()
	else: 
		buttonno = 1
		buttonpress.emit()

func _button2pressed() -> void:
	if tutorial: tutorialcontinue.emit()
	else:
		buttonno = 2
		buttonpress.emit()

func _button3pressed() -> void:
	if tutorial: tutorialcontinue.emit()
	else:
		buttonno = 3
		buttonpress.emit()

func cutscene():
	get_tree().change_scene_to_file("res://cutscene.tscn")

func gameloop(number):
	if number > 4:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://cutscene.tscn")
		#$wapassed.visible = true
		await np
	print(number)
	# Create a new scenario object from ProblemScenario based on the number
	var curscenario = ProblemScenario1.new()

	# Update the problem label text with the generated scenario's description
	$problem/Label.text = curscenario.text

	# Set the first button text
	$problem/Label/Button.text = curscenario.buttontext1

	# Set the second button text
	$problem/Label/Button2.text = curscenario.buttontext2
	
	$problem/Label/Button3.text = curscenario.buttontext3


	# Play an animation to slide in the next scenario
	$problem/AnimationPlayer.play("slidein")
	# Un-Disable Buttons so they can be pressed
	$problem/Label/Button.disabled = false
	$problem/Label/Button2.disabled = false
	$problem/Label/Button3.disabled = false
	await buttonpress
	var affect : String = "error"
	if buttonno == 1:
		affect = curscenario.affect1
	elif buttonno == 2:
		affect = curscenario.affect2
	elif buttonno == 3:
		affect = curscenario.affect3
	if $LastRating/Label.text == "OK" && affect == "OK":
		gameover.emit()
	elif affect == "BAD":
		gameover.emit()
	print(affect)
	$LastRating/Label.text = affect
	$problem/Label/Button.release_focus()
	$problem/Label/Button2.release_focus()
	$problem/Label/Button3.release_focus()
	$problem/Label/Button2.disabled = true
	$problem/Label/Button3.disabled = true
	$problem/Label/Button.disabled = true
	$problem/AnimationPlayer.play("slideout")
	if !isgameover:
		await get_tree().create_timer(1).timeout
	var nn = number + 1
	gameloop(nn)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cutscene.tscn")
