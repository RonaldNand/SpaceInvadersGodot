extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var LevelScore = 0
export (PackedScene) var spawnerType

var BGMTrack = {
	1: "res://Sound/BGAudio/Level Up.mp3",
	2: "res://Sound/BGAudio/Reformat.mp3",
	3: "res://Sound/BGAudio/Special Spotlight.mp3",
	4: "res://Sound/BGAudio/Voltaic.mp3"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	playBGM()
	get_tree().paused = true
	initialiseGame()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()

func _on_UI_MainMenu_gameStart():
	initialiseGame()

func _on_UI_GameOverlay_gameStart():
	initialiseGame() # Replace with function body.

func _on_UI_GameOverlay_retry():
	initialiseGame() # Replace with function body.

func _on_Player_playerDeath():
	gameOver() # Replace with function body.

func _on_GameOverPoint_area_entered(area):
	#if area.is_in_group("enemy"):
	gameOver() 

func _on_UI_GameOverlay_unpause():
	get_tree().paused = false # Replace with function body.
	
	
func initialiseGame():
	LevelScore = 0
	$UI_GameOverlay.toggle_UI(1)
	$Player.show()
	$Player.health = 400
	$Player.position = $PlayerSpawn.position
	$Player.readyToFire = true
	$Player.movement = true
	$Spawn.clear_enemies()
	$Spawn.spawn_enemies(2)
	$Spawn.WavesDefeated = 0
	get_tree().paused = false

func gameOver():
	$UI_GameOverlay/GameOver.show()
	get_tree().paused = true

func pauseGame():
	$UI_GameOverlay/Pause.show()
	get_tree().paused = true

func get_input():
	if Input.is_action_just_pressed("pause"):
		pauseGame()

func _on_BGM_finished():
	playBGM()
		
func playBGM():
	var track = (BGMTrack[randi() % BGMTrack.size() + 1])
	$BGM.set_stream(load(track))
	$BGM.play()

