# game.gd
extends Node2D

# Preloading all the possible shape types
var i_scene: PackedScene = preload("res://scenes/shapes/shape_i.tscn")
var t_scene: PackedScene = preload("res://scenes/shapes/shape_t.tscn")
var o_scene: PackedScene = preload("res://scenes/shapes/shape_o.tscn")
var z_scene: PackedScene = preload("res://scenes/shapes/shape_z.tscn")
var s_scene: PackedScene = preload("res://scenes/shapes/shape_s.tscn")
var l_scene: PackedScene = preload("res://scenes/shapes/shape_l.tscn")
var j_scene: PackedScene = preload("res://scenes/shapes/shape_j.tscn")

const starting_pos: Vector2 = Vector2(149, -11)

var controller: Shape
var can_control: bool = true
var rows: Dictionary[int, float] = {
	0: 21,
	1: 53,
	2: 85,
	3: 117,
	4: 149,
	5: 181,
	6: 213,
	7: 245,
	8: 277,
	9: 309,
	10: 341,
	11: 373,
	12: 405,
	13: 437,
	14: 469,
	15: 501,
	16: 533,
	17: 565,
	18: 597,
	19: 629
	}

func _ready() -> void:
	controller = generate_shape(pick_random_shape(), pick_random_color(), starting_pos)

func _process(_delta: float) -> void:

	if Input.is_action_pressed("left"):
		if can_control and controller:
			controller.move_left()
			can_control = false
			
	if Input.is_action_pressed("right"):
		if can_control and controller:
			controller.move_right()
			can_control = false
	
	if Input.is_action_pressed("down"):
		Engine.time_scale = 10.0
	else:
		Engine.time_scale = 1.0
	
	if Input.is_action_just_pressed("rotate"):
		controller.rotate_shape()
	
	if controller.is_controlled == false:
		controller = generate_shape(Enums.BlockShape.I, pick_random_color(), starting_pos)

	for row in rows:
		if is_full(rows[row]):
			print("full line!")
			remove_line(rows[row])

## Generates a shape based on provided type, color at given position
func generate_shape(shape: Enums.BlockShape, color: Enums.BlockColor, pos: Vector2) -> Shape:
	match shape:
		
		Enums.BlockShape.I:
			var i_shape = i_scene.instantiate() as Shape
			i_shape.shape_color = color
			i_shape.global_position = pos
			$Shapes.add_child(i_shape)
			return i_shape

		Enums.BlockShape.T:
			var t_shape = t_scene.instantiate() as Shape
			t_shape.shape_color = color
			t_shape.global_position = pos
			$Shapes.add_child(t_shape)
			return t_shape
			
		Enums.BlockShape.O:
			var o_shape = o_scene.instantiate() as Shape
			o_shape.shape_color = color
			o_shape.global_position = pos
			$Shapes.add_child(o_shape)
			return o_shape
			
		Enums.BlockShape.Z:
			var z_shape = z_scene.instantiate() as Shape
			z_shape.shape_color = color
			z_shape.global_position = pos
			$Shapes.add_child(z_shape)
			return z_shape
			
		Enums.BlockShape.S:
			var s_shape = s_scene.instantiate() as Shape
			s_shape.shape_color = color
			s_shape.global_position = pos
			$Shapes.add_child(s_shape)
			return s_shape
			
		Enums.BlockShape.L:
			var l_shape = l_scene.instantiate() as Shape
			l_shape.shape_color = color
			l_shape.global_position = pos
			$Shapes.add_child(l_shape)
			return l_shape
			
		Enums.BlockShape.J:
			var j_shape = j_scene.instantiate() as Shape
			j_shape.shape_color = color
			j_shape.global_position = pos
			$Shapes.add_child(j_shape)
			return j_shape
		
		_:
			return

## Picks random shape for generation
func pick_random_shape() -> Enums.BlockShape:
	var shapes_list =  [
		Enums.BlockShape.I,
		Enums.BlockShape.T,
		Enums.BlockShape.O,
		Enums.BlockShape.Z,
		Enums.BlockShape.S,
		Enums.BlockShape.L,
		Enums.BlockShape.J
	]
	return shapes_list.pick_random()

## Picks random color for generation
func pick_random_color() -> Enums.BlockColor:
	var colors_list = [
		Enums.BlockColor.BLUE,
		Enums.BlockColor.PURPLE,
		Enums.BlockColor.GREEN,
		Enums.BlockColor.YELLOW,
		Enums.BlockColor.RED
	]
	return colors_list.pick_random()

## Checks if the line is full
func is_full(row: float) -> bool:
	var counter: int = 0
	for block in get_tree().get_nodes_in_group("Blocks"):
		if block.global_position.y == row:
			counter += 1 # does not work..
	if counter == 10:
		return true
	else:
		return false

## Removes a full line
func remove_line(row: float) -> void:
	for block in get_tree().get_nodes_in_group("Blocks"):
		if block.global_position.y == row:
			block.get_parent().remove_block(block)

## Moves all the blocks after set interval passes
func _on_world_timer_timeout() -> void:
	var shapes = $Shapes.get_children()
	for shape in shapes:
		shape.fall()

func _on_player_input_timer_timeout() -> void:
	can_control = true
