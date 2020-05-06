extends KinematicBody

# Declare member variables here.
export(int) var SPEED : int = 4
export(int) var MAX_SPEED : int  = 8
export(float) var LOOKAROUND_SPEED : float = 1
export(float) var WEIGHT : float = 1

var vel_y = 0
var jumping = true

# accumulators for rotation
var rot_x = 0
var rot_y = 0

var _last_mouse_x = 0
var _last_mouse_y = 0

var _direction

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.make_current()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta : float):
	movement(delta)
	clamp_rotation()
	var clamped_origin = get_transform().origin
	clamped_origin.x = clamp(clamped_origin.x, -255, 255)
	clamped_origin.z = clamp(clamped_origin.z, -255, 255)
	set_transform(Transform(get_transform().basis, clamped_origin))
	# Global.set_debug_vector(clamped_origin)

func movement(delta):
	var speed : int = 0
	var direction : Vector3 = Vector3()
	
	# check input and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= Vector3(sin(rot_x),0,cos(rot_x))
	if Input.is_action_pressed("move_backward"):
		direction += Vector3(sin(rot_x),0,cos(rot_x))
	if Input.is_action_pressed("move_left"):
		direction -= Vector3(cos(-rot_x),0,sin(-rot_x))
	if Input.is_action_pressed("move_right"):
		direction += Vector3(cos(-rot_x),0,sin(-rot_x))
	if Input.is_action_pressed("move_sprint"):
		speed = MAX_SPEED
	else:
		speed = SPEED
	
	# for debug label
	_direction = direction
	
	# Move X- and Z- Axis
	move_and_slide(direction * speed)
	
	Global.clear_debug()
	# handle collisions
	for i in get_slide_count():
		process_collision(get_slide_collision(i))
	
	if Input.is_action_just_pressed("move_jump") and not jumping:
		vel_y = 0.05
		jumping = true
	
	# apply gravity to new direction
	vel_y -= WEIGHT / 400
	direction = Vector3(0, vel_y*250, 0)
	
	# Move Y-Axis
	move_and_slide(direction)
	#vel_y = direction.y
	
	# handle collisions
	for i in get_slide_count():
		process_collision(get_slide_collision(i))



func process_collision(event : KinematicCollision):
	if event.collider.is_class("KinematicBody"):
		emit_signal("contrast_saturation_noise")
	elif event.position.y < get_translation().y:
		vel_y = 0
		jumping = false
		Global.set_debug("on the floor!")

func clamp_rotation():
	rot_y = clamp(rot_y, -1.3, 1.3)
	if rot_x > PI*2:
		rot_x -= PI*2
	elif rot_x < 0:
		rot_x += PI*2

func _input(event):
	if event is InputEventMouseMotion: #and event.button_mask & 1:
		# modify accumulated mouse rotation
		rot_x -= event.relative.x * (LOOKAROUND_SPEED/100)
		rot_y -= event.relative.y * (LOOKAROUND_SPEED/100)
		transform.basis = Basis() # reset rotation
		clamp_rotation()
		rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
		#rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in X
		$Camera.transform.basis = Basis()
		$Camera.rotate_object_local(Vector3(1, 0, 0), rot_y)
	# Jump!
	#elif not jumping and event is InputEventKey and event.get_scancode()==KEY_SPACE and event.is_pressed() and not event.is_echo():
		#vel_y = 0.05
		#jumping = true
