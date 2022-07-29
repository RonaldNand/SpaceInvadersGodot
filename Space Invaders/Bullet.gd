extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var force = Vector2(0,-300)
export var damage = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += force * delta

func destroy_bullet():
	hide()
	queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group("enemy"):
		area.hit(damage)
	destroy_bullet()
