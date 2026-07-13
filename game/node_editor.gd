extends Node2D

var sprout_node_scene = preload("res://sprout_node.tscn")
var nodes=[]
var active_node
var test2 = preload("res://test_2d.tscn")
var skipinput = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_node()
	# add it to the screen
	add_child(active_node)
	pass # Replace with function body.

func setup_node():
	active_node = sprout_node_scene.instantiate()
	# to keep the icon from blinking
	active_node.disable_mouse_enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if skipinput:
		return
	if event is InputEventMouseMotion:
		active_node.position = event.position
	elif event is InputEventMouseButton and event.pressed:
		nodes.push_back(active_node)
		active_node = sprout_node_scene.instantiate()
		add_child(active_node)
		active_node.disable_mouse_enter()

func _on_button_pressed() -> void:
	print("running game")
	# reactivate all the disabled nodes
	var game = test2.instantiate()
	add_child(game)
	# make the nodes available to be childed by the game
	for n in nodes:
		n.enable_mouse_enter()
		remove_child(n)
	game.setup(nodes)
	skipinput=true
	remove_child($Button)
	
	# start the game by instantiating the test_2d scene here, but swap in the node positions that have already been placed
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	# hide the active_node
	if active_node != null:
		skipinput=true
		remove_child(active_node)
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	if active_node != null:
		skipinput
		add_child(active_node)
	pass # Replace with function body.
