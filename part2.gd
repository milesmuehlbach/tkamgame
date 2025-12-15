extends Node2D
@onready var desk = $Desk
@onready var deskbg = $Deskbg
@onready var textboxani: AnimationPlayer = $"Railroad-idle/AnimationPlayer"
@onready var problemani: AnimationPlayer = $problem/AnimationPlayer
var talking : bool = false
var tutorial : bool = false
var debug : bool = false
var isresponse : bool = false
var buttonno = 0
var boxnum
var problemno
var years
var months
var tempmonths = 0
var scenariocounter = 0
var money : int = 500000
var textspeed = 0.015
var affect
var redflashing = false
var finished = false

signal pressedspace
signal tutorialcontinue
signal finishtalking
signal gameover
signal buttonpress
signal np
signal starttimer

	# Update the UI label  
func _ready() -> void:
	if Autoloadvars.fasttext:
		textspeed = 0.015
	else:
		textspeed = 0.03
	$fade.position.x = 5000
	print($fade.position.x)
	gohandler()
	textboxani.play("RESET")
	problemani.play("RESET")
	$timah/AnimationPlayer.play("RESET")
	$"Railroad-idle/dialouge".text = ""
	runtutorial()

func gohandler():
	await gameover
	$fade.position.x = -713
	$fade/AnimationPlayer.play("fadein")

func say(text, num):
	var lasttext = ""
	$"Railroad-idle/dialouge".text = ""
	talking = true
	for i in len(text):
		lasttext = lasttext + text[i]
		$"Railroad-idle/dialouge".text = lasttext
		await get_tree().create_timer(textspeed).timeout
	talking = false
	finishtalking.emit()


func runtutorial():
	textboxani.play("RESET")
	textboxani.play("slideup")
	print("slid up")
	await tutorial
	say("Welcome to your job as a network tech!", 1)
	await finishtalking
	await pressedspace and talking == false
	say("You know the drill, do your thing.", 2)
	await finishtalking
	await pressedspace and talking == false
	say("What's that?", 5)
	await finishtalking
	await pressedspace and talking == false
	redflash()
	say("They're attacking our network!", 6)
	await finishtalking
	await pressedspace and talking == false
	timer()
	say("You've got 60 seconds to save our company!", 6)
	await finishtalking
	await pressedspace and talking == false
	say("Go Go Go!!!", 6)
	await finishtalking
	await pressedspace and talking == false
	starttimer.emit()
	tutorial = false
	textboxani.stop()
	gameloop(1)
	$"Railroad-idle/AnimationPlayer".play("slidedown")

func mouseadj(item, intensityy, intensityx, yoffset):
	var mouseposx = clamp(get_viewport().get_mouse_position().x,0,1100)
	var mouseposy = clamp(get_viewport().get_mouse_position().y,0,650)
	item.position.x = mouseposx/intensityx
	item.position.y = mouseposy/intensityy + yoffset 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tutorial or isresponse:
		$"Railroad-idle/AnimationPlayer".play("idle")
	mouseadj(desk, 30, 70, -140)
	mouseadj(deskbg, 100, 100, 0)



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slideup":
		tutorial = true
	if anim_name == "slidedown":
		$"Railroad-idle".visible = false
	if anim_name == "fadein":
		get_tree().change_scene_to_file("res://gameover.tscn")
	if anim_name == "moveout":
		$shop.visible = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		pressedspace.emit()

func button3pressed():
	if tutorial == true:
		pass
	else:
		buttonno = 3
		buttonpress.emit()

func _button2pressed() -> void:
	if tutorial == true:
		tutorialcontinue.emit()
	else:
		buttonno = 2
		buttonpress.emit()
		


func _button1pressed() -> void:
	if tutorial == true:
		tutorialcontinue.emit()
	else:
		buttonno = 1
		buttonpress.emit()
		
func gameloop(number):
	if number > 4:
		$wapassed.visible = true
		await np
	print(number)
	# Create a new scenario object from ProblemScenario based on the number
	var curscenario = ProblemScenario2.new()

	# Update the problem label text with the generated scenario's description
	$problem/Label.text = curscenario.text

	# Set the first button text
	$problem/Label/Button.text = curscenario.buttontext1

	# Display the first response (this will simulate text appearing)

	# Set the second button text
	$problem/Label/Button2.text = curscenario.buttontext2
	
	$problem/Label/Button3.text = curscenario.buttontext3


	# Play an animation to slide in the next scenario
	$problem/AnimationPlayer.play("slidein")
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
	await get_tree().create_timer(1).timeout
	var nn = number + 1
	gameloop(nn)
	
	
	

func tutskip():
		$"Railroad-idle".visible = false
		$"Railroad-idle/AnimationPlayer".play("slidedown")
		$problem/Label/Button.disabled = false
		$problem/Label/Button2.disabled = false
		gameloop(1)


func platforms() -> void:
	get_tree().change_scene_to_file("res://railroad_builder.tscn")


func _on_button_pressed() -> void:
	pressedspace.emit()


func _on_nextb_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	finished = true
	
func redflash():
	redflashing = true
	while redflashing:
		$redflash.visible = true
		await get_tree().create_timer(0.7).timeout
		$redflash.visible = false
		await get_tree().create_timer(0.7).timeout
		
func timer() -> void:
	var timeleft := 60.0
	
	$timah/AnimationPlayer.play("slidedown")
	await starttimer  # your custom signal to begin
	
	$timah/Timer.start()
	
	while timeleft > 0.0 and is_instance_valid($timah):
		timeleft = $timah/Timer.time_left
		$timah/Label.text = str("%.2f" % timeleft)  # fast, twitchy updates
		if !finished:
			await get_tree().process_frame  # update every frame
	
	get_tree().change_scene_to_file("res://gameover.tscn")
