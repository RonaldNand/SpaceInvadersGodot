extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#TODO Refactor movement function
#fix undo bugs

export (PackedScene) var cell
export var length = 4
var numTable
var cells
var tableStates = []
var cellSize
var startingPosition = Vector2(100,100)



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	position = startingPosition
	numTable = createTable(length)
	cells = createTable(length)
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


func createTable(length):
	#Create a square table of proportions length x length
	var table = []
	for x in length:
		table.append([])
		for y in length:
			table[x].append(0)
	return table

func populateTable():
	#Populate an instance of cell into each spot in table array.
	#TO-DO improve code so offset is not hardcoded. 
	var row_offset = 0
	var col_offset = 0
	for x in length:
		col_offset = x * 64 
		for y in length:
			row_offset = y * 64
			cells[x][y] = cell.instance()
			cells[x][y].position += Vector2(row_offset, col_offset)
			add_child(cells[x][y])

func setNewNumber():
	copyGridState()
	var freeSpots = []
	for x in range (0,length):
		for y in range (0,length):
			#Locate free spots in grid
			if (numTable[x][y] == 0):
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
	numTable[c1[0]][c1[1]] = 2
	numTable[c2[0]][c2[1]] = 2
	setCells()

func setCells():
	for x in range (0, length):
		for y in range (0,length):
			cells[x][y].value = numTable[x][y]
	
	
func convertToCoordinate(number):
	var x = number/length 
	var y = number % length
	return [x,y]
	
func copyGridState():
	var tableState = numTable.duplicate(true)
	tableStates.append(tableState)

func restoreGridState():
	if tableStates.size() > 1:
		var state = tableStates[tableStates.size()-1]
		tableStates.remove(tableStates.size()-1)
		numTable = state
		setCells()

			
	
	

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
						if (numTable[x][y] == 0):
							break
						if (numTable[x-1][y] == numTable[x][y]):
							numTable[x-1][y] += numTable[x][y]
							numTable[x][y] = 0
							break 
						if (numTable[x-1][y] == 0):
							numTable[x-1][y] = numTable[x][y]
							numTable[x][y] = 0
							x -= 1
						else:
							break
			setNewNumber()
		"down":
			for y in range (0,length):
				for x in range (length - 1 ,-1,-1):
					while (x < length-1):
						if (numTable[x][y] == 0):
							break
						if (numTable[x+1][y] == numTable[x][y]):
							numTable[x+1][y] += numTable[x][y]
							numTable[x][y] = 0
							break 
						if (numTable[x+1][y] == 0):
							numTable[x+1][y] = numTable[x][y]
							numTable[x][y] = 0
							x += 1
						else:
							break
			setNewNumber()
		"left":
				for x in range (0,length):
					for y in range (1,length):
						while (y > 0):
							if (numTable[x][y] == 0):
								break
							if (numTable[x][y-1] == numTable[x][y]):
								numTable[x][y-1] += numTable[x][y]
								numTable[x][y] = 0
								break 
							if (numTable[x][y-1] == 0):
								numTable[x][y-1] = numTable[x][y]
								numTable[x][y] = 0
								y -= 1
							else:
								break
				setNewNumber()
		"right":
			for x in range (0,length):
				for y in range (length-1,-1,-1):
					while (y < length-1):
						if (numTable[x][y] == 0):
							break
						if (numTable[x][y+1] == numTable[x][y]):
							numTable[x][y+1] += numTable[x][y]
							numTable[x][y] = 0
							break 
						if (numTable[x][y+1] == 0):
							numTable[x][y+1] = numTable[x][y]
							numTable[x][y] = 0
							y += 1
						else:
							break
			setNewNumber()
#



