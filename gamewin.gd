extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("gameoverani")
	$score.text = "Score:\n" + str(Autoloadvars.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("Pressed")
	Autoloadvars.reset()
	get_tree().change_scene_to_file("res://gamescene.tscn")
