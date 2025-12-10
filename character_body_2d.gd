extends CharacterBody2D


const SPEED = 200.0

func updateani(direction):
	if is_on_floor():
		if direction == 0:
			$AnimationPlayer.play("Idle")
		else:
			$AnimationPlayer.play("Walk")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction != 0:
		$Sprite2D.flip_h = (direction == -1)
	updateani(direction)
	if Autoloadvars.moving == true:
		move_and_slide()
