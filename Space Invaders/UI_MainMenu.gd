extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal gameStart

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GameStart_pressed():
	emit_signal("gameStart")
	toggle_UI(0)

func toggle_UI(x):
	#Pass 0 to Hide all UI Elements, Pass 1 to Show All UI Elements
	for n in get_child_count():
		match x:
			0: 
				get_child(n).hide()
			1:
				get_child(n).show()
