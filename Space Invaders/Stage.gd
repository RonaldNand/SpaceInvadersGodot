extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var LevelScore = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_UI_gameStart():
	initialiseGame() # Replace with function body.

func _on_GameOverPoint_area_entered(area):
	#if area.is_in_group("enemy"):
	gameOver() 

func initialiseGame():
	pass

func gameOver():
	$UI.game_over()
