extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	set_color(Color("red"))
	queue_redraw()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	#set_color(Color("white"))
	#queue_redraw()
	pass # Replace with function body.
