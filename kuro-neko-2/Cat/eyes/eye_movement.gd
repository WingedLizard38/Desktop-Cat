extends Sprite2D

@export var main:Node2D

@onready var start_pos := position
@onready var start_pos_g := global_position
@export var positions: Array[Vector2i]

## Movement radius when looking at mouse
@export var max_distance := 8

var target_pos:Vector2

var look_at_mouse = false

func _ready():
	await get_tree().create_timer(randf_range(3.0, 5.0)).timeout
	change_direction()

func _process(delta):
	if main.frozen or main.is_dragging: # Dragging or frozen, then look
		look_at_mouse = true
		var win_pos = Vector2(DisplayServer.window_get_position())
		var character_cen_pos = win_pos + Vector2(main.new_side_length/2, main.new_side_length/2)
		var mouse_pos = DisplayServer.mouse_get_position()
		
		target_pos = (Vector2(mouse_pos) - character_cen_pos).normalized() * max_distance
	
	elif look_at_mouse: # Else turn off look if on
		look_at_mouse = false
		await get_tree().create_timer(0.3).timeout
		target_pos = start_pos
	
	position = lerp(position, Vector2(target_pos), delta*9)

func change_direction():
	# Pick random target pos
	positions.shuffle()
	target_pos = positions[0]
	
	# Wait then switch back
	await get_tree().create_timer(randf_range(1.6, 4.0)).timeout
	target_pos = start_pos
	
	# Wait then loop
	await get_tree().create_timer(randf_range(8.0, 12.0)).timeout
	change_direction() # Loop
	
