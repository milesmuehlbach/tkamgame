extends Node2D

var talking = false
var textspeed = 0.015

signal finishtalking

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

func starttalking():
	say("The Jury has conferred, and they decided that the defendant is guilty.")
	await finishtalking
	await get_tree().create_timer(1.5).timeout
	say("The defendent will be placed in jail awaiting sentencing.")
	await finishtalking
	await get_tree().create_timer(1.5).timeout
	say("The court is no longer in session.")
	await finishtalking
	await get_tree().create_timer(1.5)
	$cutsceneplayer.play("fadeout")
	
func menu():
	get_tree().change_scene_to_file("res://menu.tscn")
	
func _ready() -> void:
	$"Railroad-idle/AnimationPlayer".play("RESET")
	$cutsceneplayer.play("RESET")
	$cutsceneplayer.play("cutscene")
