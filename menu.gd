extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.position.x = 0

	$AnimationPlayer.play("fadeout")
	
func removerect():
	$ColorRect.position.x = 5000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_check_button_pressed() -> void:
	if $VBox/FastTextCheck.button_pressed:
		Autoloadvars.fasttext = true
	else:
		Autoloadvars.fasttext = false
	print(Autoloadvars.fasttext)

func play():
	get_tree().change_scene_to_file("res://part1.tscn")

func _on_button_pressed() -> void:
	$ColorRect.position.x = 0
	$AnimationPlayer.play("fadein")
