extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var distance = 128
export var health = 100
var movement = true
var movementType = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	pass


func move():
	if movement:
		match movementType:
			0:
				position += Vector2(0,distance)
				movementType += 1
			1:
				position += Vector2(distance,0)
				movementType += 1
			2:
				position += Vector2(-distance,0)
				movementType = 0
				

func die():
	get_parent().get_parent().LevelScore += 1
	hide()
	queue_free()

func hit(damage):
	health -= damage
	if health <= 0:
		die()

func _on_MovementTimer_timeout():
	move() # Replace with function body.
