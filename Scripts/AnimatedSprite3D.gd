extends AnimatedSprite3D

func _ready():
	Global.resize_window()
	pass
	
func _physics_process(delta):
	rotate(Vector3( 0, 1, 0), PI/32)
