extends Control
@export var label_text= "1"
@export var number = 1 
var connections =0
var color_rect_hide = false
# Called when the node enters the scene tree for the first time.
func _ready():
	update_label()
	pass # Replace with function body.

func update_label():
	$"sprout label".text = str(number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_not_full():
	return connections <3
func inc_connections():
	connections +=1
	if connections > 2:
		$"sprout label/circle".inactivate()
		$"sprout label/circle".queue_redraw()
		pass
func disable_mouse_enter():
	color_rect_hide = true
func enable_mouse_enter():
	color_rect_hide = false
func _on_mouse_entered():
	if color_rect_hide:
		return
	print("sprout node entered")
	#$"ColorRect".color = Color("red")
	$ColorRect.show()
	pass # Replace with function body.


func _on_sprout_label_mouse_entered():
	print("sprout node entered")

	pass # Replace with function body.




func _on_mouse_exited():
	#$"sprout label/circle/ColorRect".visible = false
	#$"ColorRect".color = Color("white")
	$ColorRect.hide()
	pass # Replace with function body.
