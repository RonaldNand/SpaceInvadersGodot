extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sfx = "res://Sound/mixkit-pixel-chiptune-explosion-1692.wav"

# Called when the node enters the scene tree for the first time.
func _ready():
	$SFX.set_stream(load(sfx))
	$SFX.play()
	play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Explosion_animation_finished():
	queue_free()
