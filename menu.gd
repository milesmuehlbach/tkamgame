extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_mouse_entered(Argument1) -> void:
	pass # Replace with function body.


func _on_check_button_pressed() -> void:
	if $CheckButton.button_pressed:
		Autoloadvars.fasttext = true
	else:
		Autoloadvars.fasttext = false
	print(Autoloadvars.fasttext)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://part1.tscn")
