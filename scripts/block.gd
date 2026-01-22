# block.gd
extends Area2D
class_name Block

# Make blocks above screen invisible
func _process(_delta: float) -> void:
	if global_position.y < 0:
		visible = false
	else:
		visible = true
