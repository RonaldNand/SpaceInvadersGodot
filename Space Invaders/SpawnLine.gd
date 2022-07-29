extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var enemy
export var spawnValue = [0.2,0.4,0.6,0.8]
export var numberWaves = 1
export var distance = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies(numberWaves)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func spawn_enemies (waves):
	
	if waves < 1:
		pass
	
	var spot = $Line
	for n in waves:
		var offset = Vector2(0,n * distance)
		for number in (spawnValue): 
			spot.unit_offset = number
			var spawn = enemy.instance()
			spawn.position = spot.position
			spawn.position += offset
			add_child(spawn)
		
