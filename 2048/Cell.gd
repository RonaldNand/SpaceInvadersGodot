extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	#get_input()
	if (value != null):
		$ColorRect/Label.text = str(value)
	else:
		$ColorRect/Label.text = ""

