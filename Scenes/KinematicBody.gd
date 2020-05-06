extends KinematicBody

export(float) var GRAVITY : float = 9.8

func _ready():
	pass

func _process(delta):
	move_and_slide(Vector3(0, -GRAVITY, 0))
	
	var pl_pos = get_viewport().get_camera().get_camera_transform().origin
	pl_pos = Vector3(pl_pos.x, get_translation().y, pl_pos.z)
	$AnimatedSprite3D.look_at(pl_pos, Vector3(0, 1, 0))
	
	$AnimatedSprite3D.scale = Vector3(16, 16, 0)
	
	var dist = self.get_translation().distance_to(Global.get_player().get_translation())
	$HeartParticles.emitting = dist < 2.5
