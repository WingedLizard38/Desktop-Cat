extends AnimatedSprite2D

@export var anims: AnimationPlayer

func _ready():
	play("blink")
	blink() # Blink loop
	
	twitch() # Twitch loop

func blink():
	await get_tree().create_timer(randi_range(7, 21)).timeout
	#await get_tree().create_timer(randi_range(2, 2)).timeout # Faster blink for testing
	
	# Double blink
	if randf() < 0.3:
		play("blink")
		await get_tree().create_timer(0.3).timeout
	play("blink")
	
	blink() # Loop again

func twitch():
	await get_tree().create_timer(randi_range(7, 14)).timeout
	#await get_tree().create_timer(0.5).timeout # Set to 0.5 for testing
	
	var r = randf()
	
	if r < 0.33: # Front Ear
		anims.play("ear")
	elif r < 0.66: # Back Ear
		anims.play("ear2")
	else:
		anims.play("tail")
	
	twitch() # Loop again
