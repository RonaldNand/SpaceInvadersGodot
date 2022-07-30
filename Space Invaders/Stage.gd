extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var LevelScore = 0
export (PackedScene) var spawnerType
var retry = false

# Called when the node enters the scene tree for the first time.
#func _ready():
#	$Player.hide()
#


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_UI_MainMenu_gameStart():
	initialiseGame()

func _on_UI_GameOverlay_gameStart():
	initialiseGame() # Replace with function body.

func _on_UI_GameOverlay_gameOver():
	retry() # Replace with function body.

func _on_GameOverPoint_area_entered(area):
	#if area.is_in_group("enemy"):
	gameOver() 

func initialiseGame():
	LevelScore = 0
	$UI_GameOverlay.toggle_UI(1)
	if retry:
		$Spawner.free()
	$Player.position = $PlayerSpawn.position
	$Player.readyToFire = true
	$Player.movement = true
	var spawner = spawnerType.instance()
	spawner.set_name("Spawner")
	spawner.position = $SpawnerLocation.position
	add_child(spawner)

func gameOver():
	$UI_GameOverlay/GameOver.show()
	$Player.readyToFire = false;
	$Player.movement = false;
	var num = $Spawner.get_child_count()
	for x in num:
		if $Spawner.get_child(x).is_in_group('enemy'):
			$Spawner.get_child(x).movement = false
	retry = true

func retry():
	$Player.readyToFire = false;
	$Player.movement = false;
	var num = $Spawner.get_child_count()
	for x in num:
		if $Spawner.get_child(x).is_in_group('enemy'):
			$Spawner.get_child(x).movement = false
	retry = true
	initialiseGame()
	








