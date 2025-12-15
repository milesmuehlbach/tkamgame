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
var scene_changing: bool = false

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

# ---------------- READY ----------------
func _ready() -> void:
	textspeed = 0.015 if Autoloadvars.fasttext else 0.03
	$fade.position.x = 5000

	textboxani.play("RESET")
	problemani.play("RESET")
	dialogue_label.text = ""

	runtutorial()

func say(text: String, num := 0): 
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
	await say("Hey there. It's the 1930s, and my name is Atticus Finch.")
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
	$fade.position.x = -713
	fadeani.play("fadein")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slideup":
		tutorial = true
	elif anim_name == "slidedown":
		$"Railroad-idle".visible = false
	elif anim_name == "fadein":
		get_tree().change_scene_to_file("res://gameover.tscn")

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
func gameloop(number: int) -> void:
	# 1. Check for end of game BEFORE doing any UI work
	if number > 6:
		scene_changing = true
		get_tree().change_scene_to_file("res://cutscene.tscn")
		return

	# 2. Reset the scenario
	var curscenario = ProblemScenario1.new()
	$problem/Label.text = curscenario.text

	var answers = [
		{ "text": curscenario.buttontext1, "affect": curscenario.affect1 },
		{ "text": curscenario.buttontext2, "affect": curscenario.affect2 },
		{ "text": curscenario.buttontext3, "affect": curscenario.affect3 }
	]

	answers.shuffle()

	current_affects = [
		answers[0].affect,
		answers[1].affect,
		answers[2].affect
	]

	$problem/Label/Button.text = answers[0].text
	$problem/Label/Button2.text = answers[1].text
	$problem/Label/Button3.text = answers[2].text

	# Enable buttons
	$problem/Label/Button.disabled = false
	$problem/Label/Button2.disabled = false
	$problem/Label/Button3.disabled = false

	problemani.play("slidein")

	# 3. Wait for the signal
	await buttonpress
	
	# Check if scene is changing after await
	if scene_changing or not is_instance_valid(self):
		return

	# 4. Handle results
	var affect = current_affects[buttonno - 1]

	if affect == "BAD":
		gameover.emit()
		return

	if $LastRating/Label.text == "OK" and affect == "OK":
		gameover.emit()
		return

	$LastRating/Label.text = affect

	# Disable buttons immediately so player can't double-click
	$problem/Label/Button.disabled = true
	$problem/Label/Button2.disabled = true
	$problem/Label/Button3.disabled = true

	problemani.play("slideout")
	
	# Wait for animation to finish before looping
	await problemani.animation_finished
	
	# Check if scene is changing after await
	if scene_changing or not is_instance_valid(self):
		return
	
	# Use a small delay for pacing
	await get_tree().create_timer(0.5).timeout
	
	# Check if scene is changing after await
	if scene_changing or not is_instance_valid(self):
		return

	gameloop(number+1)
