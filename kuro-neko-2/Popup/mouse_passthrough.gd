extends HBoxContainer

@onready var popup = get_parent().get_parent().get_parent()

func _on_check_box_toggled(toggled_on):
	if Engine.has_singleton("MousePassthrough"):
		Engine.get_singleton("MousePassthrough").set_passthrough(popup.get_parent().get_window().get_window_id(), true)
		popup.close_window()
