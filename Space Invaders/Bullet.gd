extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var force = Vector2(0,300)
export var bulletOffset = Vector2(0,33)
export var direction = -1
export var damage = 100

var bulletOwner = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	if bulletOwner == "enemy":
		$Sprite.texture = load("res://Art/Sprites/spaceshooter/laserRed12.png")
	position += direction * bulletOffset
	playAudio(bulletOwner)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * force * delta

func destroy_bullet():
	hide()
	queue_free()


func _on_Bullet_area_entered(area):
	if bulletOwner == "enemy":
		if area.is_in_group("enemy"):
			return 0
		elif area.is_in_group("player"):
			area.hit(damage)
	elif bulletOwner == "player":
		if area.is_in_group("player"): 
			return 0
		elif area.is_in_group("enemy"):
			area.hit(damage)
	destroy_bullet()

func playAudio(index):
	match index:
		"player":
			$LaserSFX1.play()
		"enemy":
			$LaserSFX2.play()


