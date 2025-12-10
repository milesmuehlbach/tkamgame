extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("gameoverani")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("Pressed")
	Autoloadvars.usedscenariospt1.clear()
	Autoloadvars.usedscenariospt2.clear()
	get_tree().change_scene_to_file("res://menu.tscn")
