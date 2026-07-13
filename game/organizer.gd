extends Node

var nodes = []

var node_entered
var node_start
var node_end
var game_over = preload("res://game_over.tscn")
var line_and_label = preload("res://line_and_label.tscn")
var dragging = false
var players
var active_player
var colors = []
var active_color
var line
# plan is that maybe we don't include the hand drawing at first, but that comes later
# instead we start with a straigt line and when the move the mouse up or down it becomes more or less curved
# or we go with the other idea that a node that is clicked starts, then the mouse must be held until the next one is selected
# the curve just goes between
# letting go interrupts the status
# then we make a new node in the middle 
# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("sprout nodes")
	# bind the mouse entered nodes
	for node in nodes:
		# set up so that the node is part of parameter for function when things run
		node.mouse_entered.connect(determine_start_vs_end.bind(node))
	players = get_tree().get_nodes_in_group("players")
	active_player = players.pop_front()
	players.append(active_player)
	colors.append(Color("red"))
	colors.append(Color("blue"))
	active_color = colors.pop_front()
	colors.append(active_color)
	
	pass # Replace with function body.
var lines_list = []

func clearLines():
	# break because this is a failed line
	dragging = false
	# reset the node start too
	node_start = null
	node_end = null
	# remove the line so we can restart
	for line in lines_list:
		line.queue_free()
	lines_list = []

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and node_entered:
				print("Left button was clicked at ", event.position)
				node_start = node_entered
				dragging = true
				node_entered = null
				line = Line2D.new()
				line.antialiased = true
				lines_list.push_back(line)
				line.default_color = Color("black")
				line.add_point(event.position)
				add_child(line)
			# hit a target at end of dragging
			if dragging and not event.pressed and node_entered:
				dragging = false
				node_end = node_entered
				node_entered = null
				if  node_start == null or node_end ==null:
					clearLines()
					return
				# need to include a "3 or fewer connections check"
				# check the start node
				var can_start = node_start.check_not_full()
				var can_end = node_end.check_not_full()
				var self_loop_ok = true
				if node_start == node_end and (node_start.connections + node_end.connections)>1:
					self_loop_ok = false
					
				if can_start and can_end and self_loop_ok:
					node_start.inc_connections()
					node_end.inc_connections()
					# commit the pair to a selection and prepare to draw a line
					var start_pos = node_start.position
					var end_pos = node_end.position 
					var labeled_line = line_and_label.instantiate()
					var sum = node_start.number + node_end.number
					
					# this used to be the way to draw the line
					#labeled_line.start = start_pos
					#labeled_line.end = end_pos
					
					
					
					# get the labels of the start and end, and then sum them
					labeled_line.number =sum
					
					active_color = colors.pop_front()
					colors.append(active_color)
					add_child(labeled_line)
					
					# now we want to make use of the curve we drew
					labeled_line.copy_line(line)
					labeled_line.generate_label()
					labeled_line.set_line_color(active_color)
					# change color of the line 
					
					# don't forget to connect the new sprout node to the signal system
					labeled_line.label.mouse_entered.connect(determine_start_vs_end.bind(labeled_line.label))
					# add the points for the player and alternate who's turn it is
					active_player.change_score(sum)
					active_player = players.pop_front()
					players.append(active_player)
					# take away the temporary line
					# check if the game can continue
					var ending_check_nodes = get_tree().get_nodes_in_group("sprout nodes")
					# bind the mouse entered nodes
					
					var can_continue =0
					for node in ending_check_nodes:
						# set up so that the node is part of parameter for function when things run
						# the above will continue until all nodes report that they are 
						if node.check_not_full():
							can_continue+=1
					if can_continue<2:
						var go = game_over.instantiate()
						add_child(go)
						go.add_winner(get_winner())
					# reset the start and end nodes since we completed a line
					clearLines()
				else:
					clearLines()		
			# missed a target
			if dragging and not event.pressed and node_entered == null:
				clearLines()
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			print("Wheel up")
	if dragging and event is InputEventMouseMotion:
		if node_entered == null and node_start !=null and node_end !=null:
			clearLines()
			return
		line.add_point(event.position)
			
func determine_start_vs_end(n):
	print("entered")
	node_entered = n
	# we will combine our knownledge about the mouse pressed option to determine whether the sprout nodes are start or end nodes

func get_winner():
	var p1 = players[0]
	var p2 = players[1]
	if p1.score> p2.score:
		return p1.pname
	else:
		return p2.pname	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var p1 = players[0]
	var p2 = players[1]
	var go = game_over.instantiate()
	add_child(go)
	# check scores and if tie, call the tie function
	var tie = p1.score == p2.score
	if tie:
		go.add_tie()
	else:
		go.add_winner(get_winner())
	pass # Replace with function body.
