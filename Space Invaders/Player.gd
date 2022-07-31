extends KinematicBody2D


export (int) var speed = 400
export var bulletOffset = Vector2(0,-50)
export (PackedScene) var weapon
var velocity = Vector2()
var readyToFire = false
var movement = false
var soundIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if movement:
		get_input()
		move_and_slide(velocity)
		fire()



func get_input():
	
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
#	if Input.is_action_pressed("move_down"):
#		velocity.y += 1
#	if Input.is_action_pressed("move_up"):
#		velocity.y -= 1
	velocity = velocity.normalized() * speed

func fire():
	
	if (Input.is_action_just_pressed("fire")):
		if (readyToFire): 
			var bullet = weapon.instance()
			bullet.position = position
			get_parent().add_child(bullet)
			readyToFire = false;
			$ShotTimer.start()
			if !($LaserSFX1.is_playing()):
				$LaserSFX1.play()

func die():
	hide()
	queue_free()

func hit():
	die() 


func _on_ShotTimer_timeout():
	readyToFire = true; 

#func playAudio(index):
#	match index:
#		0:
#			$LaserSFX1.play()
#			soundIndex += 1
#		1:
#			$LaserSFX2.play()
#			soundIndex = 0

