extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var distance = 128
export var health = 100
export var movementTime = 3
var readyToMove = false
var movementType = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MovementTimer.set_wait_time(movementTime) # Replace with function body.
	
func _process(delta):
	if (readyToMove):
		move()

func _on_MovementTimer_timeout():
	readyToMove = true # Replace with function body.


func move():
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
	readyToMove = false
			

func die():
	get_parent().get_parent().LevelScore += 1
	$AnimatedSprite.play("explode")
	hide()
	queue_free()

func hit(damage):
	health -= damage
	if health <= 0:
		die()

