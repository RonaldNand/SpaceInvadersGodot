extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var enemy
export var spawnValue = [0.2,0.4,0.6,0.8]
export var numberOfEnemies = 5
export var numberWaves = 2
export var distance = 128
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies(numberWaves)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wave_alive()
	

func spawn_enemies (waves):
	
	if numberWaves < 0:
		pass
	
	var spot = $Line
	for n in waves:
		var offset = Vector2(0,n * distance)
		for number in (numberOfEnemies):
			spot.unit_offset = 0.1 + (number * 0.15)
			var spawn = enemy.instance()
			spawn.position = spot.position
			spawn.position += offset
			add_child(spawn)
			
func wave_alive():
	if (get_child_count() <= 2):
		if $SpawnTimer.get_time_left() <= 0:
			$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	spawn_enemies(numberWaves)
