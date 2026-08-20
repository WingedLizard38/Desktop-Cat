extends Node

"""
Prevents multiple instances from opening
"""

const LOCK_FILE_PATH := "user://game.lock"
var lock_file: FileAccess = null

func _ready() -> void:
	# Check if lock file already exists and inspect its content/timestamp
	if FileAccess.file_exists(LOCK_FILE_PATH):
		var check_file = FileAccess.open(LOCK_FILE_PATH, FileAccess.READ)
		if check_file:
			var last_time = check_file.get_64()
			var current_time = Time.get_unix_time_from_system()
			# If the last timestamp is less than 10 seconds old, assume a crash didn't happen and another instance is live
			if current_time - last_time < 10.0:
				get_tree().quit()
				return

	# Try to acquire our exclusive lock by opening/writing to the file
	lock_file = FileAccess.open(LOCK_FILE_PATH, FileAccess.WRITE)
	if lock_file:
		lock_file.store_64(Time.get_unix_time_from_system())
		lock_file.flush()
	
	# Set up a repeating timer or notification check to update the heartbeat timestamp
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.autostart = true
	timer.timeout.connect(_update_heartbeat)
	add_child(timer)

func _update_heartbeat() -> void:
	if lock_file:
		lock_file.seek(0)
		lock_file.store_64(Time.get_unix_time_from_system())
		lock_file.flush()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_EXIT_TREE:
		if lock_file:
			lock_file = null
			# Clean up the lock file when exiting normally
			DirAccess.remove_absolute(ProjectSettings.globalize_path(LOCK_FILE_PATH))
