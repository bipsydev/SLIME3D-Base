extends KinematicBody

var v = 0

func _ready():
	pass

func _physics_process(delta):
	v -= .01
	move_and_slide(Vector3(0, -4, 0))