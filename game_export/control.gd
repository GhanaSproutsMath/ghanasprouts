extends Control

@onready var handLine = $Line2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var anchors = []
var interpolationSteps = 5
var pressed
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("hideOG"):
		handLine.hide()
	if event is InputEventMouseButton:
		var recast: InputEventMouseButton = event
		if recast.pressed:
			anchors.append(recast.position)	
			print(anchors)
			handLine.add_point(recast.position)
			pressed = true
	if Input.is_action_just_released("click"):
	
		pressed=false
	if event is InputEventMouseMotion:
		var recast: InputEventMouseMotion = event
		if pressed:
			anchors.append(recast.position)	
			print(anchors)
			handLine.add_point(recast.position)
	if Input.is_action_pressed("draw_line"):
		
		
		# sample from the line a set number of points to use
		var num_elements = anchors.size()
		var mid_index = num_elements/2
		var start = anchors[0]
		var rounds = 200
		var skip =5
		while anchors.size() > skip*2:
			rounds-=1
			if rounds < 0:
				break
			# get the next two points in the line to work with
			var newline = Line2D.new()
			newline.default_color = Color("red")
			var mid = anchors[skip]
			#iterate over the anchors passing a certain number in between
			var end = anchors[skip*2]
			for i in range(interpolationSteps):
				print(float(i)/interpolationSteps)
				newline.add_point(interp(start,mid,end,float(i)/interpolationSteps))
		
			
			newline.add_point(end)
			print(newline.points)
			add_child(newline)
			start = end
			anchors = anchors.slice(skip*2,-1)
		var newline = Line2D.new()
		newline.default_color = Color("red")
		newline.add_point(anchors[0])
		newline.add_point(anchors[-1])
		add_child(newline)

func interp(p1,p2,p3,t):
	var q1 = p1.lerp(p2,t)
	var q2 = p2.lerp(p3,t)
	var r = q1.lerp(q2,t)
	return r

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
