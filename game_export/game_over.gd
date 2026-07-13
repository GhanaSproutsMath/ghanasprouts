extends Control


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_tie():
	$ColorRect/Tie.show()

func add_winner(name):
	var new_string = $"ColorRect/Win".text + str(name)
	$"ColorRect/Win".text = new_string
	$ColorRect/Win.show()
