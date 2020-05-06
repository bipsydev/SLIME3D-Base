extends Node

var debug_label: String setget set_debug, get_debug


func _ready():
	var debug_label = "nothin"

#func _process(delta):

func set_debug(s:String):
	debug_label = s
func append_debug(s:String):
	debug_label += "\n"+s
func set_debug_vector(v:Vector3):
	debug_label = "x: " + str(round_at(v.x, -1)) + "\ny: " + str(round_at(v.y, -1)) + "\nz: " + str(round_at(v.z, -1))
func clear_debug():
	debug_label = ""

func get_debug():
	return debug_label


func get_player():
	return get_node("/root/Main/Spatial/Player")


func resize_window():
	var window_size = OS.get_window_size()
	var screen_size = OS.get_screen_size()
	OS.set_window_size(Vector2(window_size.x*3, window_size.y*3))
	var new_window_size = OS.get_window_size()
	var new_window_x = (screen_size.x/2) - new_window_size.x/2
	var new_window_y = (screen_size.y/2) - new_window_size.y/2
	OS.set_window_position(Vector2(new_window_x, new_window_y))


func round_at(num : float, dec : int):
	return round(num / pow(10, dec)) * pow(10, dec)
