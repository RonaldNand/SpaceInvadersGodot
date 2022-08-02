extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var distance = 128
export var health = 100
export var movementTime = 3
export (PackedScene) var explosion
export (PackedScene) var weapon 
var readyToMove = false
var movementType = 0
var justFired = false

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
	var random = randf()
	if random >= 0.8 && not(justFired):
		fire()
		justFired = true
	else:
		justFired = false

func die():
	get_parent().get_parent().LevelScore += 1
	var deathExplosion = explosion.instance()
	deathExplosion.position = position
	get_parent().add_child(deathExplosion)
	hide()
	queue_free()

func hit(damage):
	health -= damage
	if health <= 0:
		die()

func fire():
	var bullet = weapon.instance()
	bullet.position = position
	bullet.direction = 1
	bullet.bulletOwner = "enemy"
	get_parent().add_child(bullet)

