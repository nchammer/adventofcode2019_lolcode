class Node:
 def __init__(self):
  self.parent = None
  self.id = None

def read_input():
 with open('day6_input.txt') as file:
  tuples = [tuple(line.strip().split(')', 1)) for line in file]
 return tuples

def build_orbits_dict(tuples):
 return {tuple[1] : tuple[0] for tuple in tuples}
 
def count_orbits(tuples, orbits_dict):
 orbits = 0
 for orbited, orbiting in tuples:
  print ("counting for {}".format(orbiting))
  current = orbiting
  while current != 'COM':
   print ("current is {}".format(current))
   current = orbits_dict[current]
   orbits += 1
 return orbits

def get_path_to_object(object, orbits_dict):
 path = []
 while True:
  path.append(object)
  if object == 'COM':
   break
  object = orbits_dict[object]
 return path

def get_required_transfers(path1, path2):
 loc1 = len(path1) - 1
 loc2 = len(path2) - 1
 while loc1 > 0 and loc2 > 0:
  print("path1 loc {}, path2 loc {}".format(loc1,loc2))
  print("path1 val {}, path2 val {}".format(path1[loc1], path2[loc2]))
  if path1[loc1] != path2[loc2]:
   break  # found nearest common parent
  loc1 -= 1
  loc2 -= 1
 return loc1 + loc2

tuples = read_input()
orbits_dict = build_orbits_dict(tuples)
print(orbits_dict)
orbits_count = count_orbits(tuples, orbits_dict)
print (orbits_count)
path_to_you = get_path_to_object('YOU', orbits_dict)
print(path_to_you)
path_to_san = get_path_to_object('SAN', orbits_dict)
print(path_to_san)
required_transfers = get_required_transfers(path_to_you, path_to_san)
print("required transfers: {}".format(required_transfers))
