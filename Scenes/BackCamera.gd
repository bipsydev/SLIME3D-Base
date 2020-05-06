extends Camera

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.look_at(Global.get_player().get_transform().origin, Vector3(0, 1, 0))
