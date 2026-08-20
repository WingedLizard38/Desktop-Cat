extends Sprite2D

@export var main: Node2D
@export var arm:Sprite2D

@export var hue_shift = 0:
	set(value):
		hue_shift = value
		set_hue()

@export var hue_shader:ShaderMaterial
@export var rainbow_shader:ShaderMaterial


func _ready():
	if !main.rainbow:
		material = hue_shader
		arm.material = null
		set_hue()
	else:
		material = rainbow_shader
		arm.material = rainbow_shader

func set_hue():
	if !main.rainbow:
		material.set_shader_parameter("shift_amount", hue_shift)
