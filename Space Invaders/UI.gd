extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var default_message = "Don't Let the Aliens Reach the Bottom. Move Left: W/Left. Move Right: D/Right. Shoot: Space/Click"

signal gameStart
signal gameOver

# Called when the node enters the scene tree for the first time.
func _ready():
	game_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	show_score()


func _on_GameStart_pressed():
	$Title.hide()
	$Message.hide()
	$GameStart.hide()
	$ScoreBackground.show()
	$Retry.show()
	emit_signal("gameStart")
	
	
func game_start():
	$Retry.hide()
	$ScoreBackground.hide()
	$GameOver.hide()
	$Title.show()
	$Message.show()
	$GameStart.show()
	

func game_over():
	$GameOver.show()

func show_score():
	$ScoreBackground/Score.text= "Score: " + String(get_parent().LevelScore)

	


func _on_RetryGameOver_pressed():
	$GameOver.hide()
	emit_signal("gameStart") # Replace with function body.


func _on_Retry_pressed():
	emit_signal("gameOver") # Replace with function body.

