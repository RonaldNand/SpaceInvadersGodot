extends KinematicBody2D

export (int) var baseHealth = 400
export (int) var speed = 400
export var bulletOffset = Vector2(0,-50)
export var time_between_shots = 0.2
export (PackedScene) var weapon
export (PackedScene) var explosion
var velocity = Vector2()
var readyToFire = false
var movement = false
var health = baseHealth
signal playerDeath

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotTimer.set_wait_time(time_between_shots) 

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
			#if not($LaserSFX1.is_playing()):
#			$LaserSFX1.play()

func die():
	var deathExplosion = explosion.instance()
	deathExplosion.position = position
	get_parent().add_child(deathExplosion)
	yield(get_tree().create_timer(1.0),"timeout" )
	emit_signal("playerDeath")
	hide()

func hit(damage):
	health -= damage
	if health <= 0:
		die()
	else:
		var damageExplosion = explosion.instance()
		damageExplosion.set_scale(Vector2(0.3,0.3))
		add_child(damageExplosion)


func _on_ShotTimer_timeout():
	readyToFire = true; 

func reinitialise():
	health = baseHealth
	$Player.position = $PlayerSpawn.position
	readyToFire = true
	movement = true



