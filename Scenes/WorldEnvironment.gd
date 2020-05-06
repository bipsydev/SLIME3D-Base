extends WorldEnvironment

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass #environment.adjustment_enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if environment.adjustment_enabled:
		environment.adjustment_contrast = 1 + randf() * 4
		environment.adjustment_saturation = 1 + randf() * 4
		environment.adjustment_brightness = .2 + randf() * 3.8
