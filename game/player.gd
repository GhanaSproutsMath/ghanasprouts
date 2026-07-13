extends Control

@export var pname = "name"
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$name.text = pname
	pass # Replace with function body.

func change_score(val):
	score +=val
	$name/score.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
