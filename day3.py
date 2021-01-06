def get_segment(segment_string):
	return segment_string[:1], int(segment_string[1:])

def get_segment_list(path_string):
	return list(map(get_segment, path_string.split(",")))

def make_locations_dict(path):
	locations = {}
	cur_x = 0
	cur_y = 0
	path_distance = 0
	for segment in path:
		direction, segment_distance = segment
		for count in range(segment_distance):
			if direction == "U":
				cur_y += 1
			elif direction == "D":
				cur_y -= 1
			elif direction == "L":
				cur_x -= 1
			elif direction == "R":
				cur_x += 1
			# only store shortest path to a node
			path_distance += 1
			key = (cur_x, cur_y)
			if key not in locations:
				locations[key] = path_distance
	return locations

def find_closest_intersection(locations_1, locations_2, type):
	closest_intersection = (float('inf'), float('inf'))
	closest_distance = float('inf')
	for intersection in locations_1.keys() & locations_2.keys():
		if type == "manhattan":
			distance = abs(intersection[0]) + abs(intersection[1])
		else: # "path"
			distance = locations_1[intersection] + locations_2[intersection]
		if distance < closest_distance:
			closest_distance = distance
			closest_intersection = intersection
	return closest_intersection, closest_distance

w1_path_string = input("Enter wire 1 path:")
w2_path_string = input("Enter wire 2 path:")

w1_path = get_segment_list(w1_path_string)
w2_path = get_segment_list(w2_path_string)

locations_1 = make_locations_dict(w1_path)
locations_2 = make_locations_dict(w2_path)

# part 1
closest_intersection, distance = find_closest_intersection(locations_1, locations_2, "manhattan")
print ("Part1 closest intersection: {},{}".format(closest_intersection[0], closest_intersection[1]))
print ("Part1 distance: {}".format(distance))

# part 2
closest_intersection, distance = find_closest_intersection(locations_1, locations_2, "path")
print ("Part2 closest intersection: {},{}".format(closest_intersection[0], closest_intersection[1]))
print ("Part2 distance: {}".format(distance))
