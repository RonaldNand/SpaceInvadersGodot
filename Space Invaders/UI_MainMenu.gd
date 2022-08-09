extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CreditsText.hide()
	$MainMenuBGM.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GameStart_pressed():
	play_SelectSFX()
	get_tree().change_scene("res://Stage.tscn")
	print("Godot")
	#toggle_UI(0)

func _on_MuteSound_pressed():
	play_SelectSFX()
	var idx = AudioServer.get_bus_index("SFX")
	if AudioServer.is_bus_mute(idx):
		AudioServer.set_bus_mute(idx,false)
	else:
		AudioServer.set_bus_mute(idx,true)

func _on_MuteMusic_pressed():
	play_SelectSFX()
	var idx = AudioServer.get_bus_index("BGM")
	if AudioServer.is_bus_mute(idx):
		AudioServer.set_bus_mute(idx,false)
	else:
		AudioServer.set_bus_mute(idx,true)

func _on_Credits_pressed():
	if ($CreditsText.is_visible()):
		$CreditsText.hide()
	else:
		$CreditsText.show()
	


	
func play_SelectSFX():
	$SelectSFX.play()

func toggle_UI(x):
	#Pass 0 to Hide all UI Elements, Pass 1 to Show All UI Elements
	for n in get_child_count():
		match x:
			0: 
				get_child(n).hide()
			1:
				get_child(n).show()









