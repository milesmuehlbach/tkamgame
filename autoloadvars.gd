extends Node
var usedscenariospt1 : Array = []
var usedscenariospt2 : Array = []
var fasttext : bool = true
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset():
	usedscenariospt1.clear()
	usedscenariospt2.clear()
	fasttext = true
	score = 0
