extends Sprite2D

@onready var image_size = get_parent().image_size.x # Must be square
@onready var char_size = get_parent().char_size
@export var area_2d:Area2D # Hitbox

var screen_size

"""
func _ready():
	screen_size = Vector2(DisplayServer.screen_get_size())
	
	# Pick smallest dimension
	var smallest = screen_size[0]
	if screen_size[1] < screen_size[0]: smallest = screen_size[1]
	
	# Variables
	var desired_size = smallest / char_size
	var scale_multi = round(desired_size/image_size)
	var new_side_length = scale_multi*image_size
	
	scale = Vector2(scale_multi, scale_multi)
	
	# Resize the collision box (Its also centered so)
	area_2d.get_child(0).shape.size = Vector2(new_side_length, new_side_length)
	var middle = int(new_side_length/2)
	area_2d.get_child(0).position = Vector2(middle, middle)
	
	# Resize viewport
	get_window().size = Vector2(new_side_length, new_side_length)
	print(scale)
	print(get_window().size)
"""
	
