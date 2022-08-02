extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var enemy
export var spawnValue = [0.2,0.4,0.6,0.8]
export var numberOfEnemies = 5
export var numberWaves = 2
export var distance = 128
var WavesDefeated = 0
var EnemyMovementFactor = 0
var EnemyHealthFactor = 0
var defaultElements = 0

signal difficultyIncrease


# Called when the node enters the scene tree for the first time.
func _ready():
	defaultElements = get_child_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wave_alive()
	

func spawn_enemies (waves):
	
	var startSpot = rand_range(0.03,0.3)
	
	if numberWaves < 0:
		pass
	
	var spot = $Line
	for n in waves:
		var offset = Vector2(0,n * distance)
		for number in (numberOfEnemies):
			spot.unit_offset = startSpot + (number * 0.15)
			var spawn = enemy.instance()
			spawn.position = spot.position + offset
			spawn.movementTime -= EnemyMovementFactor
			spawn.health += EnemyHealthFactor 
			add_child(spawn)

func clear_enemies():
	for number in get_child_count():
		if get_child(number).is_in_group("enemy"):
			get_child(number).queue_free()
			
func wave_alive():
	if (get_child_count() <= defaultElements):
		if $SpawnTimer.get_time_left() <= 0:
			$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	spawn_enemies(numberWaves)
	WavesDefeated += 1
	match WavesDefeated:
		5:
			EnemyMovementFactor = 1
			emit_signal("difficultyIncrease")
		10: 
			EnemyMovementFactor = 2
			emit_signal("difficultyIncrease")
		15:
			numberWaves += 1
			emit_signal("difficultyIncrease")
		20:
			EnemyHealthFactor += 100
			emit_signal("difficultyIncrease")
		30: 
			EnemyHealthFactor += 100
			emit_signal("difficultyIncrease")
	
