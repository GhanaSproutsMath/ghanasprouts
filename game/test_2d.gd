extends Node2D

var main_menu = preload("res://main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setup(user_nodes):
	# if called we want to remove the existing nodes, and replace them with nodes passed in as a list
	var pre_existing_nodes = get_tree().get_nodes_in_group("sprout nodes")
	for n in pre_existing_nodes:
		n.queue_free()
	# add back in the nodes that were placed by the users
	for n in user_nodes:
		add_child(n)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_pressed() -> void:
	var success =get_tree().change_scene_to_file("res://main_menu.tscn")
	print("changed scene success ",success)
	pass # Replace with function body.
