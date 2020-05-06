extends Node

# Declare member variables here.
var allow_fullscreen = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.resize_window()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	window_input()
	update_HUD()
	#Global.set_debug_vector($Spatial/Player.rotation)
	
func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and event.get_scancode() == KEY_C:
		if $Spatial/Player/Camera == get_viewport().get_camera():
			$Spatial/Player/BackCamera.make_current()
		else:
			$Spatial/Player/Camera.make_current()
	elif event is InputEventKey and event.is_pressed() and not event.is_echo() and event.get_scancode() == KEY_L:
		$Spatial/DirectionalLight.visible = not $Spatial/DirectionalLight.visible



func window_input():
	if(Input.is_key_pressed(KEY_ALT) and Input.is_key_pressed(KEY_ENTER) and allow_fullscreen):
		allow_fullscreen = false
		OS.window_fullscreen = !OS.window_fullscreen
	elif(Input.is_key_pressed(KEY_ALT) and Input.is_key_pressed(KEY_ENTER)):
		allow_fullscreen = false
	else:
		allow_fullscreen = true
	
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()


func update_HUD():
	if Global.debug_label != null:
		$HUD/DebugLabel.text = str(Global.debug_label)
