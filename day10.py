
def read_input():
 with open('day10_input.txt') as file:
  lines = file.readlines()
  return [list(line.strip()) for line in lines]

# visible = *, invisible = o, current = @, empty = " ", not checked empty = ., not checked asteroid = #

# builds a grid of visible asteroids, and a list-of-lists ("graph") representation of all asteroids,
# where the head of each list is visible and rest are "behind" visible one in order
def build_visible_asteroids_grid_and_graph(x, y):
 asteroids = read_input()
 graph = []

 x_max = len(asteroids[0])
 y_max = len(asteroids)

 # mark current
 if asteroids[y][x] != '#':
  raise Exception('tried to build visible asteroids for a non-asteroid location {},{}'.format(x,y))
 asteroids[y][x] = '@'

 # asteroid row
 for i in range(x-1, -1, -1):
  check_location(asteroids, graph, x, y, i, y)
 for i in range(x+1, x_max):
  check_location(asteroids, graph, x, y, i, y)

 # above asteroid row
 for j in range(y-1, -1, -1):
  for i in range(x_max):
   check_location(asteroids, graph, x, y, i, j)

 # below asteroid row
 for j in range(y+1, y_max):
  for i in range(x_max):
   check_location(asteroids, graph, x, y, i, j)

 # sort graph according to laser rotation order
 # use slopes, plus arbitrarily large numbers to separate "rightward" from "leftward" laser directions
 def get_sort_slope(location_list):
  location_x, location_y = location_list[0]
  delta_x = location_x - x
  delta_y = location_y - y

  if delta_x == 0:
   if delta_y < 0:
    return -5000.0  # up is first
   else:
    return 5000.0   # down is after quadrants 1,2 but before quadrants 3,4
  slope = (delta_y * 1.0) / delta_x
  if delta_x < 0:   # put quadrants 3,4 after quadrants 1,2 with same slope
   slope += 10000.0
  return slope

 graph.sort(key=get_sort_slope)
 return (asteroids, graph)

# check a location, and if asteroid found, mark all concealed asteroids as found and invisible also
# intended to be called first from points "closer" to the candidate station
def check_location(grid, graph, candidate_x, candidate_y, location_x, location_y):
 x_range = len(grid[0])
 y_range = len(grid)

 x_step = location_x - candidate_x
 y_step = location_y - candidate_y

 found_on_path = False
 asteroids_list = []
 while location_x >= 0 and location_x < x_range and location_y >= 0 and location_y < y_range:
  #print ('checking in while loop {},{}'.format(location_x, location_y))
  location_value = grid[location_y][location_x]
  if location_value == '*' or location_value == 'o' or location_value == '_':
   return   # already checked
  if location_value == '#':
   asteroids_list.append((location_x, location_y))
   if not found_on_path:
    found_on_path = True
    grid[location_y][location_x] = '*'
   else:
    grid[location_y][location_x] = 'o'
  elif location_value == '.':
    grid[location_y][location_x] = '_'
  else:
   raise Exception('Should not have already checked location {},{}'.format(location_x, location_y))
  location_x += x_step
  location_y += y_step

 if len(asteroids_list) > 0:
  graph.append(asteroids_list)

# create sequence that asteroids will be exploded by laser
def sequence_asteroid_explosions(graph):
 output = []
 found_more = True
 while found_more:
  found_more = False
  for list in graph:
   if len(list) > 0:
    output.append(list.pop(0))
    found_more = True
 return output

def count_visible(grid):
 return sum(line.count('*') for line in grid)

def print_grid(asteroids):
 for row in asteroids:
  print(''.join(row))

# main program start
asteroids = read_input()
x_count = len(asteroids[0])
y_count = len(asteroids)

most_asteroids = -1
most_asteroids_location = (-1, -1)
most_asteroids_grid = []
most_asteroids_graph = []
for y in range(y_count):
 for x in range(x_count):
  if asteroids[y][x] == '#':
   #print('building grid for asteroid at {},{}'.format(x, y))
   grid, graph = build_visible_asteroids_grid_and_graph(x, y)
   #print_grid(grid)
   #print(graph)
   #print()
   current_count = count_visible(grid)
   if current_count > most_asteroids:
    most_asteroids = current_count
    most_asteroids_location = (x, y)
    most_asteroids_grid = grid
    most_asteroids_graph = graph

explosion_list = sequence_asteroid_explosions(most_asteroids_graph)

print ('Most asteroids: {} at location {}'.format(most_asteroids, most_asteroids_location))
print_grid(most_asteroids_grid)
print('Explosion order:')
print(explosion_list)
if len(explosion_list) >= 200:
 print("200th asteroid to explode is {}".format(explosion_list[199]))
