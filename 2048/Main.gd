extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#TODO Refactor movement function
#fix undo bugs

export (PackedScene) var cell
export var length = 4
var table = []
var tableStates = []
var cellSize
var startingPosition = Vector2(100,100)



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	position = startingPosition
	initiliseTable(length)
	populateTable()
	setNewNumber()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()

func get_input():
	if (Input.is_action_just_pressed("move_up")):
		moveGrid("up")
	if (Input.is_action_just_pressed("move_down")):
		moveGrid("down")
	if (Input.is_action_just_pressed("move_left")):
		moveGrid("left")
	if (Input.is_action_just_pressed("move_right")):
		moveGrid("right")
	if (Input.is_action_just_pressed("undo")):
		restoreGridState()


func initiliseTable(length):
	#Create a square table of proportions length x length
	for x in length:
		table.append([])
		for y in length:
			table[x].append(0)

func populateTable ():
	#Populate an instance of cell into each spot in table array.
	#TO-DO improve code so offset is not hardcoded. 
	var row_offset = 0
	var col_offset = 0
	for x in length:
		col_offset = x * 64 
		for y in length:
			row_offset = y * 64
			table[x][y] = cell.instance()
			table[x][y].position += Vector2(row_offset, col_offset)
			add_child(table[x][y])

func setNewNumber():
	copyGridState()
	var freeSpots = []
	for x in range (0,length):
		for y in range (0,length):
			#Locate free spots in grid
			if (table[x][y].value == null):
				#Convert grid reference to number e.g [3][2] becomes 14
				var num = x * length + y  
				freeSpots.append(num)
	if (freeSpots.size() < 2):
		print("No More Space")
		#TO-DO Implement Game Reset on No Space
		return 0
	var number1= randi() % freeSpots.size()
	var c1 = convertToCoordinate(freeSpots[number1])
	freeSpots.remove(number1)
	var number2= randi() % freeSpots.size()
	var c2 = convertToCoordinate(freeSpots[number2])
	table[c1[0]][c1[1]].value = 2
	table[c2[0]][c2[1]].value = 2
	
	
func convertToCoordinate(number):
	var x = number/length 
	var y = number % length
	return [x,y]
	
func copyGridState():
	var tableState = []
	for x in length:
		tableState.append([])
		for y in length:
			tableState[x].append(0)
	
	for x in range (0,length):
		for y in range (0,length):
			if (table[x][y].value == null):
				tableState[x][y] = 0
			else:
				tableState[x][y] = table[x][y].value
	tableStates.append(tableState)

func restoreGridState():
	var state = tableStates[tableStates.size()-1]
	tableStates.remove(tableStates.size()-1)
	for x in range (0,length):
		for y in range (0,length):
			if state[x][y] == 0:
				table[x][y].value == null
			else: 
				table[x][y].value = state[x][y]

			
	
	

func moveGrid(direction):
	#Refactor if possible. 
	#If a square is blank (null value) ignore and move onto next square.
	#Rule 1: If the next square is blank move the square with value up until it merges or hits another square.
	#Rule 2: If a square merges, then stop moving it once 
	match direction:
		"up":
			for y in range (0,length):
				for x in range (1,length):
					while (x > 0):
						if (table[x][y].value == null):
							break
						if (table[x-1][y].value == table[x][y].value):
							table[x-1][y].value += table[x][y].value
							table[x][y].value = null
							break 
						if (table[x-1][y].value == null):
							table[x-1][y].value = table[x][y].value
							table[x][y].value = null
							x -= 1
						else:
							break
			setNewNumber()
		"down":
			for y in range (0,length):
				for x in range (length - 1 ,-1,-1):
					while (x < length-1):
						if (table[x][y].value == null):
							break
						if (table[x+1][y].value == table[x][y].value):
							table[x+1][y].value += table[x][y].value
							table[x][y].value = null
							break 
						if (table[x+1][y].value == null):
							table[x+1][y].value = table[x][y].value
							table[x][y].value = null
							x += 1
						else:
							break
			setNewNumber()
		"left":
			for x in range (0,length):
				for y in range (1,length):
					while (y > 0):
						if (table[x][y].value == null):
							break
						if (table[x][y-1].value == table[x][y].value):
							table[x][y-1].value += table[x][y].value
							table[x][y].value = null
							break 
						if (table[x][y-1].value == null):
							table[x][y-1].value = table[x][y].value
							table[x][y].value = null
							y -= 1
						else:
							break
			setNewNumber()
		"right":
			for x in range (0,length):
				for y in range (length-1,-1,-1):
					while (y < length-1):
						if (table[x][y].value == null):
							break
						if (table[x][y+1].value == table[x][y].value):
							table[x][y+1].value += table[x][y].value
							table[x][y].value = null
							break 
						if (table[x][y+1].value == null):
							table[x][y+1].value = table[x][y].value
							table[x][y].value = null
							y += 1
						else:
							break
			setNewNumber()
		
		



