extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var LevelScore = 0
export (PackedScene) var spawnerType
var retry = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_UI_MainMenu_gameStart():
	initialiseGame()

func _on_UI_GameOverlay_gameStart():
	initialiseGame() # Replace with function body.

func _on_UI_GameOverlay_retry():
	initialiseGame() # Replace with function body.


func _on_GameOverPoint_area_entered(area):
	#if area.is_in_group("enemy"):
	gameOver() 
	
func initialiseGame():
	LevelScore = 0
	$UI_GameOverlay.toggle_UI(1)
	$Player.position = $PlayerSpawn.position
	$Player.readyToFire = true
	$Player.movement = true
	$Spawn.clear_enemies()
	$Spawn.spawn_enemies(2)
	get_tree().paused = false

func gameOver():
	$UI_GameOverlay/GameOver.show()
	get_tree().paused = true












