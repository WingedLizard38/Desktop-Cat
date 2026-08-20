extends Node2D

var win_pos: Vector2
var velocity = Vector2(1,1)

var screen_size = Vector2()
##Dimensions of the image (Only works properly when square)
@export var image_size = Vector2i(370, 370)
var actual_size = 0

var is_dragging = false
var drag_offset = Vector2()
var idle_timer = 0.0

var smallest_side
## Character will take up 1/char_size of the screen
@export var char_size = 15:
	set(value):
		char_size = value
		if ready_: _ready()

var desired_size 
var scale_multi
var new_side_length 

var ready_ = false # True once the ready function has run

@onready var viewport = $SubViewport
@onready var sprite = $SubViewport/Char
@onready var area = $Area2D

## Turn on outlines
@export var outline_weight = 5:
	set(value):
		outline_weight = value
		
		notify_property_list_changed()
		if ready_: _ready()


@export var cup:Sprite2D # Cup has its own hue shift code stored in _ready
@export var rainbow = false:
	set(value):
		rainbow = value
		
		if ready_: _ready(); cup._ready()

@export var rainbow_shader:ShaderMaterial

@export var popup_menu:Window
var frozen = false # Prevents movement when menu is open

func _ready(): # Also called when one of these vars is updated
	#region Effects
	$Render.material.set_shader_parameter("line_thickness", outline_weight)
	
	if rainbow:
		sprite.material = rainbow_shader # cat
		sprite.get_child(6).material = rainbow_shader # eyes
		sprite.get_child(1).material = rainbow_shader # ears and tail
		sprite.get_child(2).material = rainbow_shader
		sprite.get_child(3).material = rainbow_shader
	else:
		sprite.material = null # cat
		sprite.get_child(6).material = null # eyes
		sprite.get_child(1).material = null # ears and tail
		sprite.get_child(2).material = null
		sprite.get_child(3).material = null
	#endregion
	
	screen_size = Vector2(DisplayServer.screen_get_size())
	win_pos = Vector2(DisplayServer.window_get_position())
	
	# Pick smallest dimension
	smallest_side = screen_size[0]
	if screen_size[1] < screen_size[0]: smallest_side = screen_size[1]
	
	desired_size = smallest_side / char_size
	scale_multi = desired_size/image_size.x
	if scale_multi == 0: # Image was too large to divide - ignore pixel perfect
		scale_multi = desired_size/image_size.x
	
	new_side_length = scale_multi*image_size.x
	# Needs to be integers due to issues with rounding and detecting when to bounce
	actual_size = Vector2i(new_side_length, new_side_length)
	
	#Resize sprite
	sprite.scale = Vector2(scale_multi, scale_multi)
	
	# Resize the collision box (Its also centered so)
	area.get_child(0).shape.size = Vector2(new_side_length, new_side_length)
	var middle = int(new_side_length/2)
	area.get_child(0).position = Vector2(middle, middle)
	
	# Resize viewports
	get_window().size = Vector2(new_side_length, new_side_length)
	viewport.size = Vector2(new_side_length, new_side_length)
	
	ready_ = true

func _physics_process(delta):
	if frozen: # Skip everything
		return
	
	if is_dragging:
		var mouse_pos = Vector2(DisplayServer.mouse_get_position())
		velocity = (mouse_pos - drag_offset - win_pos)
		win_pos = lerp(win_pos, mouse_pos - drag_offset, delta * 10)
	elif velocity.length() < image_size.x/3: # Moving too slow
		velocity = Vector2.ZERO
		return

	win_pos += velocity * delta
	win_pos.x = clamp(win_pos.x, 0, screen_size.x - actual_size.x)
	win_pos.y = clamp(win_pos.y, 0, screen_size.y - actual_size.y)
	DisplayServer.window_set_position(Vector2i(win_pos))

	# Bounce
	if win_pos.x == 0 or win_pos.x >= screen_size.x - actual_size.x:
		velocity.x *= -1
	if win_pos.y == 0 or win_pos.y >= screen_size.y - actual_size.y:
		velocity.y *= -1
	
	# Friction 
	velocity = lerp(velocity, velocity.normalized() * Vector2(image_size.x/3, image_size.x/3) * 2, delta/7)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed: # Lift click to drag
		if event.button_index == MOUSE_BUTTON_LEFT and !is_dragging  and !frozen:
			is_dragging = true
			var mouse_pos = Vector2(DisplayServer.mouse_get_position())
			win_pos = Vector2(DisplayServer.window_get_position())
			drag_offset = mouse_pos - win_pos
		elif event.button_index == MOUSE_BUTTON_RIGHT and !is_dragging and !frozen: # Right click to open menu
			frozen = true
			popup_menu.open_window()

func _input(event): # Makes sure the mouse is released even when mouse is not in the hitbox
	if event is InputEventMouseButton and !event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and is_dragging:
			win_pos = Vector2(DisplayServer.window_get_position())
			velocity *= 3
			is_dragging = false
