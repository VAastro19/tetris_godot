# block.gd
extends Area2D
class_name Block

const block_size: int = 32

# Make blocks above screen invisible
func _process(_delta: float) -> void:
	if position.y < 0:
		visible = false
	else:
		visible = true

## Moves block by one grid coord down
func fall() -> void:
	position.y += block_size

## Moves block by one grid coord to the left
func move_left() -> void:
	position.x -= block_size

## Moves block by one grid coord to the right
func move_right() -> void:
	position.x += block_size
