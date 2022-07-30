extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal gameStart
signal gameOver

# Called when the node enters the scene tree for the first time.
func _ready():
	toggle_UI(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_score()
	

func game_over():
	$GameOver.show()

func update_score():
	$ScoreBackground/Score.text= "Score: " + String(get_parent().LevelScore)

	


func _on_RetryGameOver_pressed():
	$GameOver.hide()
	emit_signal("gameStart") 


func _on_Retry_pressed():
	emit_signal("gameOver") 

func toggle_UI(x):
	#Pass 0 to Hide all UI Elements, Pass 1 to Show All UI Elements
	for n in get_child_count():
		match x:
			0: 
				get_child(n).hide()
			1:
				get_child(n).show()
	$GameOver.hide()
