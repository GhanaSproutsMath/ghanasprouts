extends Node2D

var start
var end
var mid
var number
var line
var label
# Called when the node enters the scene tree for the first time.
func _ready():
	line = $Line2D
	label = $"sprout node"
	pass # Replace with function body.

func make_line():
	# set the points to be the start and end
	# 
	line.add_point(start)
	line.add_point(end)
	var half = (end - start)/2
	mid = start + half
var anchors = [] 
func makeAnchorsFromLine(other_line):
	var total_points = other_line.get_point_count()
	for i in range(total_points):
		anchors.push_back(other_line.get_point_position(i))
func interpolateAnchors():
		var start = anchors[0]
		var rounds = 200
		var skip =10
		var interp_anchors = []
		while anchors.size() > skip*2:
			rounds-=1
			if rounds < 0:
				break
			# get the next two points in the line to work with
			
			var mid = anchors[skip]
			#iterate over the anchors passing a certain number in between
			var end = anchors[skip*2]
			var interpolationSteps=5
			for i in range(interpolationSteps):
				print(float(i)/interpolationSteps)
				interp_anchors.push_back(interp(start,mid,end,float(i)/interpolationSteps))
		
			
			interp_anchors.push_back(end)
			
			start = end
			anchors = anchors.slice(skip*2,-1)
		# get the last couple points too
		if anchors.size() > 2:
			interp_anchors.push_back(anchors[0])
			interp_anchors.push_back(anchors[-1])
		return interp_anchors

func interp(p1,p2,p3,t):
	var q1 = p1.lerp(p2,t)
	var q2 = p2.lerp(p3,t)
	var r = q1.lerp(q2,t)
	return r

func copy_line(other_line:Line2D):
	
	makeAnchorsFromLine(other_line)
	var interpolated_anchors = interpolateAnchors()
	# now make the scene's line points out of the interpoalted ones
	line.points = interpolated_anchors
	# now interpolate and pass back a constructed line
	var total_points = line.get_point_count()
	
	# get the halfway point index
	# get first
	var first = line.get_point_position(0)
	var last = line.get_point_position(total_points-1)
	var half_vec = (last-first)/2
	var half_point = first + half_vec
	var half_i = floor(total_points/3)
	## do a search of the several points closest to the middle index, or behind this value since it seems to always be off
	#var best_i = half_i
	#var dist = INF
	var dist_total = 0
	for i in range(1,total_points):
		var first_i = i-1
		var second_i = i
		var p1 = line.get_point_position(first_i)
		var p2 = line.get_point_position(second_i)
		dist_total += p1.distance_to(p2)
	var half = dist_total/2
	var half_dist = 0
	print("distance total ",dist_total)
	print("distance half ",half)
	for i in range(1,total_points):
		var first_i = i-1
		var second_i = i
		var p1 = line.get_point_position(first_i)
		var p2 = line.get_point_position(second_i)
		half_dist += p1.distance_to(p2)
		if half_dist > half:
			print("stopping line calc at ",i)
			print("out of a total of ",total_points)
			mid = line.get_point_position(i)
			break
	
	# now go through and stop when we reach about the half way point
		

	
func set_line_color(c):
	line.default_color = c
	
func generate_label():
	# set the number of the middle part
	label.number = number
	# since it's new we have to add two connections because it's already part of a line
	label.inc_connections()
	label.inc_connections()
	label.label_text = str(number)
	label.update_label()
	# draw the line
	# move the label to the middle point
	label.position = mid
	label.position.x-=23
	label.position.y -=23


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
