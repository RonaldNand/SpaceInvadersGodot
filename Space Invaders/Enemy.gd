extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var distance = 100
export var health = 100
var movement = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass


func move_down():
	if movement:
		position += Vector2(0,distance)

func die():
	get_parent().get_parent().LevelScore += 1
	hide()
	queue_free()

func hit(damage):
	health -= damage
	if health <= 0:
		die()

func _on_MovementTimer_timeout():
	move_down() # Replace with function body.
