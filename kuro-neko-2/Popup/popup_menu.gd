extends Window

@export var main: Node2D

@export var image_scale:SpinBox
@export var outline_weight:SpinBox
@export var rainbow:CheckButton
@export var rainbow_speed:SpinBox
@export var shimmer:CheckButton
@export var shimmer_speed:SpinBox

@export var cup:Sprite2D

func _ready():
	hide()
	
	image_scale.value = main.char_size
	
	outline_weight.value = main.outline_weight
	
	rainbow.button_pressed = main.rainbow
	rainbow_speed.value = cup.rainbow_shader.get_shader_parameter("speed")
	shimmer.button_pressed = cup.rainbow_shader.get_shader_parameter("enable_shimmer")
	shimmer_speed.value = cup.rainbow_shader.get_shader_parameter("shimmer_speed")
	
	close_requested.connect(close_window)
	
func open_window():
	var mouse_pos_x = DisplayServer.mouse_get_position().x
	var screen_size_x = DisplayServer.screen_get_size().x
	
	if mouse_pos_x < screen_size_x/2: # Mouse on left of screen
		position.x = mouse_pos_x + main.new_side_length*.7
	else: # Mouse on right of screen
		position.x = mouse_pos_x - main.new_side_length*.7 - size.x
	position.y = DisplayServer.mouse_get_position().y
	
	show()

func close_window():
	hide()
	main.frozen = false

func close_application(toggled_on):
	get_tree().quit()

func _on_image_scale_changed(value):
	main.char_size = value

func _on_outline_value_changed(value):
	main.outline_weight = value

func _on_rainbow_toggled(toggled_on):
	main.rainbow = toggled_on

func _on_cup_hue_changed(value):
	cup.hue_shift = value

func _on_rainbow_speed_changed(value):
	cup.rainbow_shader.set_shader_parameter("speed", value)

func _on_shimmer_toggled(toggled_on):
	cup.rainbow_shader.set_shader_parameter("enable_shimmer", toggled_on)

func _on_shimmer_speed_changed(value):
	cup.rainbow_shader.set_shader_parameter("shimmer_speed", value)
