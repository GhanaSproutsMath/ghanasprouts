extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
var inactive = false
func inactivate():
	print("inactivating")
	inactive = true

func _draw():
	var white : Color = Color.WHITE
	var godot_blue : Color = Color("478cbf")
	var grey : Color = Color("414042")

	# Four circles for the 2 eyes: 2 white, 2 grey.
	if inactive:
		
		draw_circle(Vector2(0,0), 16, "black",true)
	else:
		draw_circle(Vector2(0,0), 16, "white",true)
		draw_circle(Vector2(0,0), 16, "black",false)
