# shape.gd
extends Node2D
class_name Shape

const left_edge: int = 5
const right_edge: int = 325
const bottom_edge: int = 645
const block_size: int = 32

var blocks: Array = []
var raycasts: Array[RayCast2D] = []
var shape_color: Enums.BlockColor
var is_controlled: bool = true

# Fills arrays with data and sets the color of the shape
func _ready() -> void:
	blocks = get_children()
	raycasts = get_raycasts()
	set_shape_color(shape_color)
	for block in blocks:
		block.add_to_group("Blocks")

## If no detection with outside surface is detected, moves all the blocks
func fall() -> void:
	var can_move: bool = true
	for raycast in raycasts:
		if raycast.is_colliding() and (raycast.get_collider() not in blocks):
			if (raycast.get_collider().global_position.y > raycast.global_position.y) or (raycast.get_collider() is StaticBody2D):
				can_move = false
				is_controlled = false
				break
	if can_move:
		global_position.y += block_size

## If possible moves all the blocks within a shape to the left
func move_left() -> void:
	var can_move: bool = true
	for raycast in raycasts:
		if raycast.is_colliding() and raycast.get_collider() not in blocks:
			if raycast.get_collider().global_position.x < raycast.global_position.x:
				can_move = false
				break
	for block in blocks:
		if block.global_position.x - block_size <= left_edge:
			can_move = false
			break
	if can_move:
		global_position.x -= block_size

## If possible moves all the blocks within a shape to the right
func move_right() -> void:
	var can_move: bool = true
	for raycast in raycasts:
		if raycast.is_colliding() and raycast.get_collider() not in blocks:
			if raycast.get_collider().global_position.x > raycast.global_position.x:
				can_move = false
				break
	for block in blocks:
		if block.global_position.x + block_size >= right_edge:
			can_move = false
			break
	if can_move:
		global_position.x += block_size

## Rotate shape clockwise
func rotate_shape() -> void:
	rotation_degrees += 90
	for block in blocks:
		var internal_raycast: RayCast2D = block.get_node("InternalRayCast")
		internal_raycast.force_raycast_update()
		if internal_raycast.is_colliding() and internal_raycast.get_collider() not in blocks:
			rotation_degrees -= 90
			break
		while block.global_position.x < left_edge:
			move_right()
		while block.global_position.x > right_edge:
			move_left()
		while block.global_position.y > bottom_edge:
			global_position.y -= block_size
		block.rotation_degrees -= 90

## Sets the color of the shape based on input
func set_shape_color(color: Enums.BlockColor) -> void:
	for block in blocks:
		block.set_block_color(color)

## Returns the color of the shape
func get_shape_color() -> Enums.BlockColor:
	return shape_color

## Collects all of the raycasts into a single array
func get_raycasts() -> Array[RayCast2D]:
	var new_raycasts: Array[RayCast2D] = []
	for block in blocks:
		for child in block.get_children():
			if child is RayCast2D and child != block.get_node("InternalRayCast"):
				new_raycasts.append(child)
	return new_raycasts

## Removes a block from the shape and updates all of the arrays after. Removes the shape if there are no blocks left
func remove_block(block: Block) -> void:
	blocks.erase(block)
	block.disappear()
	if blocks.is_empty():
		queue_free()
	raycasts = get_raycasts()
